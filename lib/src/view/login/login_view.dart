import 'package:flutter/material.dart';
import 'package:fss_interview/src/base/base_view.dart';
import 'package:fss_interview/src/constants/asset_constants.dart';
import 'package:fss_interview/src/helper/custom_button.dart';
import 'package:fss_interview/src/helper/custom_flutter_toast.dart';
import 'package:fss_interview/src/helper/custom_loader.dart';
import 'package:fss_interview/src/helper/custom_navigation_utils.dart';
import 'package:fss_interview/src/helper/custom_text_field.dart';
import 'package:fss_interview/src/view/dashboard/dashboard_view.dart';
import 'package:fss_interview/src/view/login/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> implements BaseView{
  TextEditingController tecPhone=TextEditingController();
  TextEditingController tecPassword=TextEditingController();
  late LoginBloc _mBloc;
  bool mLoading=false;

  @override
  void dispose() {
    tecPhone.dispose();
    tecPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init(){
    _mBloc=LoginBloc();
    _mBloc.setView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomLoader(child: loginView(),loader: mLoading)
    );
  }

  loginView(){
    return Column(children: [
      Expanded(child: ListView(shrinkWrap: true,children: [
        const SizedBox(height: 50,),
        ecommerceLogo(),
        Column(mainAxisAlignment: MainAxisAlignment.start,children: [
          welcomeUser(),
          enterYourDetailsToYourLoginAccount(),
          phone(),
          password(),
          forgotPassword(),
          const SizedBox(height: 30,),
        ],)
      ],)),
      login()
    ]);
  }

  ecommerceLogo(){
    return Padding(padding: const EdgeInsets.only(left: 50,right: 50),child: Image.asset(AssetConstants.eCommerceLogo,height: 150,width: double.maxFinite,fit: BoxFit.fill));
  }

  welcomeUser(){
    return const Padding(padding: EdgeInsets.only(left: 30,top: 50),child: Align(child: Text("Welcome User",style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),alignment: Alignment.centerLeft,),);
  }

  enterYourDetailsToYourLoginAccount(){
    return const Padding(padding: EdgeInsets.only(top: 5,left: 30,bottom: 15),child: Align(child: Text("Enter your details to login to your Account",style: TextStyle(color: Colors.black38,fontSize: 16,fontWeight: FontWeight.bold),maxLines: 2),alignment: Alignment.centerLeft,),);
  }

  phone(){
    return Padding(padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),child: CustomTextField(hintText: "Enter Username / Email ID",controller: tecPhone,keyboardType: TextInputType.phone,prefixIcon: Icons.person_outline,prefixIconColor: Colors.blue,borderColor: Colors.grey.shade400,fillColor: Colors.grey.shade100,),);
  }

  password(){
    return Padding(padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),child: CustomTextField(hideMaxLengthIndicator: true,hintText: "Password",controller: tecPassword,maxLength: 8,prefixIcon: Icons.lock,keyboardType: TextInputType.text,prefixIconColor: Colors.blue,borderColor: Colors.grey.shade400,fillColor: Colors.grey.shade100,),);
  }

  forgotPassword(){
    return const Padding(padding: EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),child: Align(child: Text("Forgot Password?",style: TextStyle(fontSize: 18,color: Colors.blue)),alignment: Alignment.centerRight,),);
  }

  login(){
    return CustomButton(height: 50, width: double.maxFinite,buttonText: "LOGIN",onPressed: (){
      FocusScope.of(context).unfocus();
      _mBloc.validateLogin(tecPhone.text,tecPassword.text);
    });
  }

  @override
  showToast(String toast) {
    CustomFlutterToast.showToast(toast);
  }

  @override
  showProgress({bool isLoading = true}) {
    setState(() {
      mLoading=isLoading;
    });
  }

  void navigateToDashboard() {
    CustomNavigationUtils.pushReplacement(context, const DashboardView());
  }

}
