import 'package:fss_interview/src/base/base_provider.dart';
import 'package:fss_interview/src/constants/api_constants.dart';
import 'package:fss_interview/src/models/get_login_details_model.dart';
import 'package:fss_interview/src/models/post_login_details_model.dart';
import 'package:fss_interview/src/models/response_model.dart';

class LoginNetworkProvider extends BaseProvider{

  Future<ResponseModel<GetLoginDetailsModel>> onLogin(PostLoginDetailsModel model) async {
    return await postData<GetLoginDetailsModel>(model.toJson(),ApiConstants.baseUrl+ApiConstants.loginUrl, isAuthorized: false, type: ResponseDataType.loginResponse);
  }

}