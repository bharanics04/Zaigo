import 'package:fss_interview/src/models/get_lawyer_details_wrapper.dart';
import 'package:fss_interview/src/models/response_model.dart';
import 'package:fss_interview/src/network_provider/dashboard_network_provider.dart';

class DashboardRepository{
  final DashboardNetworkProvider _mNetworkProvider=DashboardNetworkProvider();

  Future<ResponseModel<GetLawyerDetailsWrapper>> onGetDashboardDetailsList() async=>await _mNetworkProvider.onGetDashboardDetailsList();

}