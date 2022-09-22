import 'package:fss_interview/src/base/base_provider.dart';
import 'package:fss_interview/src/constants/api_constants.dart';
import 'package:fss_interview/src/models/get_lawyer_details_wrapper.dart';
import 'package:fss_interview/src/models/response_model.dart';

class DashboardNetworkProvider extends BaseProvider{

  Future<ResponseModel<GetLawyerDetailsWrapper>> onGetDashboardDetailsList() async {
    return await getData<GetLawyerDetailsWrapper>(ApiConstants.baseUrl+ApiConstants.dashboardListUrl, isAuthorized: true, type: ResponseDataType.lawyerList);
  }

}