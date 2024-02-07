
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:resumable_upload/resumable_upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:smarthealth/model/chat_model.dart';
import 'package:smarthealth/model/models_model.dart';
import 'package:smarthealth/services/api_consts.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "text-davinci-003";
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}


class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        log("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      log("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        log("temp ${value["id"]}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // Send Message 
  static Future<List<ChatModel>> sendMessageToAI(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        log("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}


//var storage = AzureStorage.parse(Connection_String);




// Future<void> storeTextList(fileToBeSent) async {

//  UploadClient client = UploadClient(
//         file: fileToBeSent,
//         cache: LocalCache(),
//         chunkSize: 10 * 1024 * 1024, // Default 4MB
//         timeout: const Duration(seconds: 20), // Default 30sec
//         blobConfig: BlobConfig(
//             accountName: 'AZURE_BLOB_ACCOUNT_NAME',
//             containerName: 'AZURE_BLOB_NAME',
//             blobName: 'AZURE_BLOB_NAME',
//             sasToken: 'AZURE_Sas_TOKEN', blobUrl: ''),
//     );
// }