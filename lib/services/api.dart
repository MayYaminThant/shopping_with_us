import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: Api.baseUrl,
    receiveTimeout: const Duration(milliseconds: 60000),
    connectTimeout: const Duration(milliseconds: 60000),
  ),
);

extension OnEndPoint on String {
  String onEndPoint() => Api.currentAppUrl + this;
}

class Api {
  static const String baseUrl = "http://52.221.92.136/api";
  static const String version1 = "/v1";

  static const String currentVersion = version1;
  static const String currentAppUrl = baseUrl + currentVersion;

  static void errorHandler(
      {Response? errorResponse, bool showErrorMessage = true}) {
    if (errorResponse != null) {
      {
        if (showErrorMessage) {
          BotToast.showText(
            text: errorResponse.statusMessage ??
                errorResponse.statusCode.toString(),
          );
        }
      }
    } else {
      if (showErrorMessage) {
        BotToast.showText(text: 'No Internet Connection!');
      }
    }
  }

  static developerLog({dynamic error}) {
    if (error != null && error is DioException) {
      log("REQUEST API:${error.requestOptions.uri.path}");
      log("RESPONSE CODE:${error.response?.statusCode}");
      log("RESPONSE MESSAGE:${error.response?.statusMessage}");
      log("RESPONSE DATA:${error.response?.data.toString()}");
    } else {
      log(error.toString());
    }
  }

  static Future<Response?> getDemoVendor() async {
    try {
      final Response response =
          await dio.get('/customer/dummy-vendor'.onEndPoint(),
              options: Options(
                contentType: 'application/json; charset=UTF-8',
              ));
      return response;
    } on DioException catch (e) {
      errorHandler(errorResponse: e.response);
      developerLog(error: e);
      return null;
    } catch (e) {
      developerLog(error: e);
      return null;
    }
  }

  static Future<Response?> getProductDetail() async {
    try {
      final Response response =
          await dio.get('/customer/dummy-item'.onEndPoint(),
              options: Options(
                contentType: 'application/json; charset=UTF-8',
              ));
      return response;
    } on DioException catch (e) {
      errorHandler(errorResponse: e.response);
      developerLog(error: e);
      return null;
    } catch (e) {
      developerLog(error: e);
      return null;
    }
  }
}
