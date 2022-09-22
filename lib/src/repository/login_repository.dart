import 'package:fss_interview/src/models/get_login_details_model.dart';
import 'package:fss_interview/src/models/post_login_details_model.dart';
import 'package:fss_interview/src/models/response_model.dart';
import 'package:fss_interview/src/network_provider/login_network_provider.dart';

class LoginRepository{
  final LoginNetworkProvider _mNetworkProvider=LoginNetworkProvider();

  Future<ResponseModel<GetLoginDetailsModel>> login(PostLoginDetailsModel model) async=>await _mNetworkProvider.onLogin(model);

}