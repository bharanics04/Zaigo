import 'package:fss_interview/src/constants/base_constants.dart';
import 'package:fss_interview/src/local_data_provider/local_data_provider.dart';
import 'package:fss_interview/src/models/get_lawyer_details_wrapper.dart';
import 'package:fss_interview/src/models/response_model.dart';
import 'package:fss_interview/src/repository/dashboard_repository.dart';
import 'package:fss_interview/src/view/dashboard/dashboard_view.dart';

class DashboardBloc{
  final DashboardRepository _mRepository=DashboardRepository();
  final LocalDataProvider _mLocalDataProvider=LocalDataProvider();
  late DashboardViewState _mView;

  setView(DashboardViewState view){
    _mView=view;
  }

  getLawyerList() async{
    ResponseModel<GetLawyerDetailsWrapper> responseModel=await _mRepository.onGetDashboardDetailsList();
    _mView.showProgress(isLoading: false);
    if(responseModel.status){
      _mView.setOrderDetails(responseModel.dataModel!.mLawyerList);
    }else{
      _mView.showToast(BaseConstants.somethingWentWrong);
    }
  }

  void logout() async{
    await _mLocalDataProvider.clear();
    _mView.navigateToLoginView();
  }



}