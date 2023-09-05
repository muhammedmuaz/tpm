import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Routes/app_pages.dart';
import 'appException.dart';
import 'enviroment.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

final String baseUrl = Enviroment().config.baseUrl;
final String apiUrl = Enviroment().config.apiUrl;

class Api {
  var sp = GetStorage();
  Future<dynamic> get(String url, {fullUrl}) async {
    if (url != "" || fullUrl != "") {
      final token = sp.read('token');
      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw _returnResponse(response.statusCode);
        }
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on HttpException catch (e) {
        throw BotToast.showText(text: e.message.toString());
        // return _returnResponse(
        //     Response(requestOptions: RequestOptions(data: e.toString())));
      }
    }
  }

  Future<dynamic> delete(String url) async {
    if (url != "") {
      final token = sp.read('token');
      try {
        final response = await http.delete(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        print(response.body);
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw _returnResponse(response.statusCode);
        }
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on HttpException catch (e) {
        throw BotToast.showText(text: e.message.toString());
        // return _returnResponse(
        //     Response(requestOptions: RequestOptions(data: e.toString())));
      }
    }
  }

  Future<dynamic> post(String url,
      {Map<String, String>? queryParams,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    if (url != "") {
      final token = sp.read('token');
      try {
        Uri uri = Uri.parse(url);
        if (queryParams != null && queryParams.isNotEmpty) {
          uri = uri.replace(queryParameters: queryParams);
        }
        final request = http.MultipartRequest('POST', uri);
        if (body != null && body.isNotEmpty) {
          body.forEach((key, value) {
            if (value is String) {
              request.fields[key] = value;
            } else if (value is List<String>) {
              value.forEach((element) {
                request.fields[key] = element;
              });
            } else if (value is List<File>) {
              value.forEach((file) async {
                final stream = http.ByteStream(file.openRead());
                final length = await file.length();
                final multipartFile = http.MultipartFile(
                    'files', stream, length,
                    filename: path.basename(file.path));
                request.files.add(multipartFile);
              });
            }
          });
        }
        request.headers.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
          ...headers ?? {}
        });
        final response = await request.send();
        print(response);
        if (response.statusCode == 200) {
          final responseData = await response.stream.bytesToString();
          return responseData;
        } else {
          throw _returnResponse(response.statusCode);
        }
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on HttpException catch (e) {
        throw BotToast.showText(text: e.message.toString());
      }
    }
  }

// Post Login

  Future<dynamic> postLogin(
    url, {
    required email,
    required password,
    auth = false,
  }) async {
    // Dio dio = Dio();
    // if (auth == false) {
    //   // print(sp.read ('token'));
    //   dio.options.headers['Authorization'] = "Bearer ${sp.read('token')}";
    // }

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({"Email": email, "Password": password});
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      if (jsonDecode(response.body)["Success"] == true) {
        // print(jsonDecode(response.body));
        // print(
        //     "---------------------------------------------------------------");
        // print(jsonDecode(response.body)["Data"]['UserData']['Token']);
        return jsonDecode(response.body);
      } else {
        var parts = jsonDecode(response.body)['Message']
            .replaceAll(RegExp('<[^>]*>'), '');
        errorIcon(parts);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on HttpException catch (e) {
      throw errorIcon(e.message);
    }
  }

  // Error Icon

  errorIcon(message) async {
    Timer(Duration(seconds: 3), () {});
    if (message.runtimeType == String) {
      BotToast.showText(text: message);
    } else {
      BotToast.showText(text: message['message']);
    }
  }

  dynamic _returnResponse(int response) {
    if (response < 500) {
      BotToast.showText(
          text: 'Request failed with status: ${response.toString()}.');
      Timer(const Duration(seconds: 2), () {});
      // sp.erase();
      // Get.offAllNamed(Routes.home);
    } else {
      BotToast.showText(text: "Error communicating with the server");
    }
  }
}
