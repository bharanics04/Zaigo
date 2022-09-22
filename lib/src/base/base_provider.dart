import 'package:dio/dio.dart';
import 'package:fss_interview/src/constants/base_constants.dart';
import 'package:fss_interview/src/local_data_provider/local_data_provider.dart';
import 'package:fss_interview/src/models/response_model.dart';
import 'package:fss_interview/src/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart';

const int REQUEST_TIME = 60;

class BaseProvider {

  Map<String, String> headers = {};

  Future<ResponseModel<T>> postData<T>(dynamic json, String url,
      {bool isMultipart = false,
        MultipartRequest? multipartBody,
        type = ResponseDataType.none,
        bool isAuthorized = true,
        Function(Map<String, dynamic>)? customErrorHandling,
        String? lang}) async {
    var response;
    await addHeaders(isAuthorized);
    try {
      var dio = Dio();
      dio.interceptors.add(getIntercepter());
      var reqOptions =
          Options(headers: headers, responseType: ResponseType.json);

      // make POST request
      if (isMultipart) {
        multipartBody!.headers.addAll(headers);
        response = await multipartBody.send();
      } else {
        response = await dio
            .post(url, data: json, options: reqOptions)
            .timeout(const Duration(seconds: REQUEST_TIME));
      }
      return handleResponse<T>(
          response, json == null ? null : jsonDecode(json is String ? json : jsonEncode(json)), url, type,
          isMultipart: isMultipart,
          multipartReqBody: multipartBody,
          customErrorHandling: customErrorHandling);
    } catch (error,stackTrace) {
      if(error.toString().contains("400") && type==ResponseDataType.loginResponse){
        return ResponseModel<T>(true, BaseConstants.invalidPassword);
      }
      return ResponseModel<T>(false, BaseConstants.somethingWentWrong);
    }
  }

  Future<ResponseModel<T>> putData<T>(String json, String url,
      {type = ResponseDataType.none,
        bool isMultipart = false,
        MultipartRequest? multipartBody,
        Function(Map<String, dynamic>)? customErrorHandling,
        bool isAuthorized = true}) async {

    await addHeaders(isAuthorized);
    try {
      var dio = Dio();
      dio.interceptors.add(getIntercepter());
      var response;
      if (isMultipart) {
        multipartBody!.headers.addAll(headers);
        response = await multipartBody.send();
      }
      else {
        response = await dio
          .put(url,
              data: json,
              options: Options(
                headers: headers,
              ))
          .timeout(const Duration(seconds: REQUEST_TIME));
      }
      return handleResponse(response, json, url, type, isMultipart: isMultipart,
          multipartReqBody: multipartBody,customErrorHandling: customErrorHandling!);
    } catch (error, stackTrace) {
      return ResponseModel<T>(false, BaseConstants.somethingWentWrong);
    }
  }

  Future<ResponseModel<T>> deleteData<T>(String json, String url,
      {type = ResponseDataType.none,
      bool isAuthorized = true}) async {

    await addHeaders(isAuthorized);
    try {
      var dio = Dio();
      dio.interceptors.add(getIntercepter());

      var response = await dio.delete(url,
          data: json,
          options: Options(
            headers: headers,
          ))
          .timeout(const Duration(seconds: REQUEST_TIME));
      return handleResponse<T>(response, json, url, type);
    } catch (error, stackTrace) {
      return ResponseModel<T>(false, BaseConstants.somethingWentWrong);
    }
  }

  Future<ResponseModel<T>> getData<T>(String url,
      {Map<String, dynamic> queryParams = const {},
      type = ResponseDataType.none,
      bool isAuthorized = true}) async {

    await addHeaders(isAuthorized);
    try {
      var dio = Dio();
      dio.interceptors.add(getIntercepter());
      var response = await dio
          .get(url,
              queryParameters: queryParams,
              options: Options(
                headers: headers,
              ))
          .timeout(const Duration(seconds: REQUEST_TIME));
      return handleResponse<T>(response, json, url, type);
    } catch (error, stackTrace) {
      return ResponseModel<T>(false, BaseConstants.somethingWentWrong);
    }
  }

  Future<ResponseModel<T>> handleResponse<T>(
      response, requestJsonBody, url, type,
      {isMultipart = false,
        multipartReqBody,
        Function(Map<String, dynamic>)? customErrorHandling}) async {

    var res = isMultipart
        ? jsonDecode(await response.stream.bytesToString())
        : response.data;

    if (response.statusCode >=200 && response.statusCode <300) {
        return ResponseModel.fromJson(res.runtimeType == String ? jsonDecode(res): res, type: type, statusCode: response.statusCode, message: isMultipart? null : response.statusMessage);
    }else if (response.statusCode==400) {
      return ResponseModel.fromJson(res.runtimeType == String ? jsonDecode(res): res, type: type, statusCode: true, message: isMultipart? null : response.statusMessage);
    } else {
      if (customErrorHandling != null) customErrorHandling(res);

      return ResponseModel.fromJson<T>(res, isDataAvailable: false, statusCode: response.statusCode);
    }
  }

  Interceptor getIntercepter() => LogInterceptor(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
  );

   addHeaders(bool isAuthorized)  async{
    headers['Content-Type'] = 'application/json';
    if(isAuthorized){
      String? token=await LocalDataProvider().getAccessToken();
      if(Utils.isNotEmpty(token)){
        headers['Authorization'] = "Bearer ${token!}";
      }
    }
  }
}