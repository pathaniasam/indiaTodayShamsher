import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:indiatodayshamsher/respository/network_utils.dart';

class ApiHelper {
  static CancelToken? cancelToken;

  static Dio createDio() {
    cancelToken = CancelToken();
    return Dio(BaseOptions(
      connectTimeout: 500000,
      receiveTimeout: 1000000000,
      baseUrl: NetworkUtils.BASE_URL,
    ));
  }

  static Future<Response?> post(
    String subUrl, {
    Map? body,
    FormData? formData,
    String? authtoken,
    BuildContext? context,
  }) async {
    if (body != null) body.removeWhere((k, v) => v == null);
    var client = createDio();

    if (authtoken != null) {
      client.options.headers["Authorization"] = authtoken;
    }
    print(NetworkUtils.BASE_URL + subUrl);
    Response response;
    log("--- body:" + json.encode(body));
    try {
      response = await client.post<String>(
        NetworkUtils.BASE_URL + subUrl,
        data: body != null
            ? json.encode(body)
            : formData != null
                ? formData
                : null,
      );
      log(response.data);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      } else {
        print(e.message);

        return e.response;
      }
    }
  }

  static Future<Response> get(String subUrl,
      {Map<String, dynamic>? params,
      String? authtoken,
      BuildContext? context,
      bool addBaseUrl = true}) async {
    print(params);
    var client = createDio();

    if (authtoken != null) {
      client.options.headers["Authorization"] = authtoken;
    }

    print(NetworkUtils.BASE_URL + subUrl);
    final response = await client.get<String>(
      addBaseUrl ? NetworkUtils.BASE_URL + subUrl : subUrl,
      queryParameters: params,
    );
    print("--- header:" + json.encode(client.options.headers));
    print(response);
    return response;
  }
}

class MyException {
  int statusCode;
  String message;

  MyException(this.statusCode, this.message);
}
