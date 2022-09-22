import 'package:fss_interview/src/constants/base_constants.dart';
import 'package:fss_interview/src/models/get_lawyer_details_wrapper.dart';
import 'package:fss_interview/src/models/get_login_details_model.dart';

enum ResponseDataType {
  loginResponse,
  lawyerList,
  none
}

class ResponseModel<T> {
  bool status=false;
  int statusCode;
  String message="";
  T? dataModel;

  ResponseModel(this.status, this.message, {this.statusCode = 0});

  static ResponseModel<T> fromJson<T>(response, {isDataAvailable = true, statusCode = 0, type = ResponseDataType.none, message = ""}) {
    ResponseModel<T> responseModel = ResponseModel(statusCode == 200, BaseConstants.success, statusCode: statusCode);
    var data;

    if (isDataAvailable) {
      switch (type) {
        case ResponseDataType.loginResponse:
          data = GetLoginDetailsModel.fromJson(response);
          break;
        case ResponseDataType.lawyerList:
          data = GetLawyerDetailsWrapper.fromJson(response);
          break;
      }
    }

    responseModel.dataModel = data;
    return responseModel;
  }
}