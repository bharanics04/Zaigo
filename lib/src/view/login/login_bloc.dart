import 'package:fss_interview/src/constants/base_constants.dart';
import 'package:fss_interview/src/local_data_provider/local_data_provider.dart';
import 'package:fss_interview/src/models/get_login_details_model.dart';
import 'package:fss_interview/src/models/post_login_details_model.dart';
import 'package:fss_interview/src/models/response_model.dart';
import 'package:fss_interview/src/repository/login_repository.dart';
import 'package:fss_interview/src/utils/utils.dart';
import 'package:fss_interview/src/view/login/login_view.dart';

class LoginBloc{
  final LocalDataProvider _mLocalDataProvider=LocalDataProvider();
  final LoginRepository _mLoginRepository=LoginRepository();
  late LoginViewState _mView;

  setView(LoginViewState view){
    _mView=view;
  }

  validateLogin(String phone,String password){
    if(Utils.isEmpty(phone)){
      _mView.showToast("Username is empty");
    }else if(Utils.isEmpty(password)){
      _mView.showToast("Password is empty");
    }else if(Utils.isNotEmpty(password) && password.length!=8){
      _mView.showToast("Password must contain 8 characters");
    }else{
      login(phone, password);
    }
  }

  login(String phone,String password) async{
    _mView.showProgress();
    ResponseModel<GetLoginDetailsModel> loginModel=await _mLoginRepository.login(PostLoginDetailsModel(mPhone: phone, mPassword: password));
    if(loginModel.status){
      if(loginModel.message==BaseConstants.invalidPassword){
        _mView.showProgress(isLoading: false);
        _mView.showToast(loginModel.message);
      }else{
        saveUserDetails(loginModel.dataModel!);
        _mView.navigateToDashboard();
      }
    }else{
      _mView.showProgress(isLoading: false);
      _mView.showToast(BaseConstants.somethingWentWrong);
    }
  }

  saveUserDetails(GetLoginDetailsModel model) async{
    await _mLocalDataProvider.saveUserDetails(model.mAccessToken, model.mName);
  }

}