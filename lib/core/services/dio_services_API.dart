import 'dart:convert';

// import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dio/dio.dart';

import '../configs/base_API_configs.dart';
import '../error/http_exception.dart';

class DioAPIServices extends BaseAPIConfig {
  // ignore: unnecessary_new
  BaseOptions options = new BaseOptions(
    baseUrl: "",
    followRedirects: false,
    validateStatus: (status) => true,
  );

  String? msgErrorHandle(Map _data) {
    String errorhandleMsg = 'Error Occured';

    // ignore: curly_braces_in_flow_control_structures
    if (_data.containsKey('status')) if (_data['status'] != 'failed') {
      return null;
    }

    // ignore: curly_braces_in_flow_control_structures
    if (_data.containsKey('status')) if (_data['status'] == 'failed') if (_data
        .containsKey('message')) errorhandleMsg = _data['message'];
    // ignore: curly_braces_in_flow_control_structures
    if (_data.containsKey('error')) if (_data['error'] is String) {
      errorhandleMsg = _data['error'];
    }

    return errorhandleMsg;
  }

  @override
  Future<Map?> getAPI({
    String authorization = '',
    String url = '',
  }) async {
    try {
      // if (!await ConnectivityWrapper.instance.isConnected) {
      //   throw HttpException('No Connection', 101);
      // }
      Dio _dio = Dio(options);

      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';

      if (authorization != null) {
        _dio.options.headers['authorization'] = 'Bearer $authorization';
      }

      Response _response =
          await _dio.request(url, options: Options(method: "GET"));

      // final _errorMsg = msgErrorHandle(_response.data);

      //  if (_errorMsg != null)
      //   throw HttpException(_errorMsg, _response.statusCode);

      if (_response.statusCode! < 200 && _response.statusCode! > 226) {
        throw HttpException('', _response.statusCode!);
      }

      if (_response.data is String) return null;

      if (_response.data.containsKey('errors')) {
        throw HttpException(_response.data['errors'][0], _response.statusCode!);
      }

      return _response.data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<dynamic, dynamic>?> postAPI({
    Map<String, String>? addOnHeader,
    Map? body,
    String? url,
    String? authorization,
    bool isMultiPart = false,
  }) async {
    try {
      // if (!await ConnectivityWrapper.instance.isConnected) {
      //   throw HttpException('No Connection', 101);
      // }

      dynamic _encodeJson = json.encode(body);
      if (body == null) _encodeJson = null;

      Dio _dio = Dio(options);
      _dio.options.headers['content-Type'] = 'application/json';

      if (authorization != null) {
        _dio.options.headers['authorization'] = 'Bearer $authorization';
      }

      Response _response = await _dio
          .request(url!, options: Options(method: "POST"), data: _encodeJson)
          .catchError((e) => print(e));

      print('res ${_response.data}');

      if (_response.statusCode! < 200 && _response.statusCode! > 226) {
        throw HttpException('', _response.statusCode!);
      }

      if (_response.data is String) return null;

      if (_response.data['response_code'] == 205) {
        throw throw HttpException(
            _response.data['response_data'], _response.statusCode!);
      }

      if (_response.data is Map) {
        if (_response.data.containsKey('errors'))
          // ignore: curly_braces_in_flow_control_structures
          throw HttpException(
              _response.data['errors'][0], _response.statusCode!);
      }

      return _response.data;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<Map?> deleteAPI(
      {Map<String, String>? addOnHeader,
      Map? body,
      String? url,
      int? id,
      String? authorization}) {
    // TODO: implement deleteAPI
    throw UnimplementedError();
  }

  @override
  Future<Map?> patchAPI(
      {Map<String, String>? addOnHeader, Map? body, String? url}) {
    // TODO: implement patchAPI
    throw UnimplementedError();
  }

  @override
  Future<Map?> putAPI(
      {Map<String, String>? addOnHeader, Map? body, String? url, int? id}) {
    // TODO: implement putAPI
    throw UnimplementedError();
  }
}
