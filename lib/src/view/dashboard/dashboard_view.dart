import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fss_interview/src/base/base_view.dart';
import 'package:fss_interview/src/constants/asset_constants.dart';
import 'package:fss_interview/src/helper/custom_alerts.dart';
import 'package:fss_interview/src/helper/custom_flutter_toast.dart';
import 'package:fss_interview/src/helper/custom_navigation_utils.dart';
import 'package:fss_interview/src/models/get_lawyer_details_model.dart';
import 'package:fss_interview/src/view/dashboard/dashboard_bloc.dart';
import 'package:fss_interview/src/view/login/login_view.dart';
import 'package:fss_interview/src/view/user_image_details_view/user_image_details_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> implements BaseView{
  List<GetLawyerDetailsModel>? _mLawyerList;
  late DashboardBloc _mBloc;
  bool mLoading=true;
  int _mSelectedIndex=0;

  @override
  void initState() {
    init();
    super.initState();
  }

  init(){
    _mBloc=DashboardBloc();
    _mBloc.setView(this);
    _mBloc.getLawyerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0,title: const Text("Ecommerce"),backgroundColor: Colors.blueAccent,actions: const [
      Padding(padding: EdgeInsets.all(10),child: InkWell(child: Icon(Icons.search,color: Colors.white,size: 25,),),)
    ]),body:_mSelectedIndex==0?dashboardView():const UserImageDetailsView(),drawer: Drawer(child: ListView(
      children: <Widget>[
        ecommerceLogo(),
        const SizedBox(height: 10,),
        Container(color: Colors.grey,height: 0.5,),
        ListTile(
            title: const Text("Dashboard"),
            onTap: (){
              Navigator.pop(context);
              setState(() {
                _mSelectedIndex=0;
              });
            }
        ),
        Container(color: Colors.grey,height: 0.5,),
        ListTile(
            title: const Text("Image Details"),
            onTap: (){
              Navigator.pop(context);
              setState(() {
                _mSelectedIndex=1;
              });
            }
        ),
        Container(color: Colors.grey,height: 0.5,),
        ListTile(
          title: const Text("Logout"),
          onTap: (){
            Navigator.pop(context);
            showAlertForLogout();
          }
        ),
        Container(color: Colors.grey,height: 0.5,),
      ],
    ),));
  }

  showAlertForLogout(){
    CustomAlerts.showAlertWithPositiveNegativeButton(context, "Are you sure want to log out?", "Yes", "No", (){
      Navigator.pop(context);
      _mBloc.logout();
    }, (){
      Navigator.pop(context);
    });
  }

  dashboardView(){
    return mLoading?loadingView():_mLawyerList!=null && _mLawyerList!.isNotEmpty?Column(children: [
      Container(color: Colors.blueAccent,height: 75,child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),child: Row(children: [
        Expanded(flex: 7,child: Container(color: Colors.white,height: 50,child: Row(children: const [
          SizedBox(width: 10),
          Icon(Icons.calendar_month,size: 25,color: Colors.blueAccent,),
          SizedBox(width: 10),
          Text("Start Date and Time",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
        ],))),
        Container(height: double.maxFinite,margin: const EdgeInsets.only(top: 5,bottom: 5),width: 0.5,color: Colors.grey.shade300,),
        Expanded(flex: 1,child: Container(color: Colors.white,height: 50,width: 50,child:const Icon(Icons.filter_list_alt,size: 25,color: Colors.blue,),))
      ]),margin: const EdgeInsets.all(15))),
      Padding(padding: const EdgeInsets.only(left: 20,right: 20,top: 15),child: Row(children: [
        Expanded(child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Destination Zip Code', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
              TextSpan(text: ':', style: TextStyle(color: Colors.grey)),
              TextSpan(text: '25949', style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
            ],
          ),
        )),
        const Text('Bulk Dispatch', style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
      ],),),
      Expanded(child: ListView.builder(itemCount: _mLawyerList!.length,itemBuilder: (BuildContext context,int index){
        return orderItemView(index);
      })),
      Row(children: [
        Expanded(child: Container(height: 50,color: Colors.green,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: const[
          Center(child: Text("Optimize Route",style: TextStyle(fontSize: 14,color: Colors.white),),)
        ],),)),
        Expanded(child: Container(height: 50,color: Colors.red,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: const[
          Center(child: Text("Reset",style: TextStyle(fontSize: 14,color: Colors.white),),)
        ],),)),
      ],)
    ],):Column(mainAxisAlignment: MainAxisAlignment.center,children: const [
      Center(child: Text("No orders found",style: TextStyle(color: Colors.black),),)
    ],);
  }

  loadingView(){
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: const [
      Center(child: CircularProgressIndicator())
    ],);
  }


  orderItemView(int index){
    return Container(width: double.maxFinite,padding: const EdgeInsets.all(10),margin: const EdgeInsets.all(15),child: Column(children: [
      orderDetails(index),
      const SizedBox(height: 5,),
      customerDetails(index),
      const SizedBox(height: 5),
      Container(height: 1,width: double.maxFinite,color: Colors.grey.shade300,padding: const EdgeInsets.only(left: 5,right: 5),),
      const SizedBox(height: 2.5),
      status()
    ],),decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.grey.shade400)));
  }

  orderDetails(int index){
    return Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      Expanded(child: orderId(_mLawyerList![index].mId),flex: 2,),
      const SizedBox(width: 2,),
      Expanded(child: time(_mLawyerList![index].mHoursLogged),flex: 1,)
    ]);
  }

  customerDetails(int index){
    return Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(padding: const EdgeInsets.only(top: 2,bottom: 2),child: Text(_mLawyerList![index].mName.isNotEmpty?_mLawyerList![index].mName:"-",style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
        Padding(padding: const EdgeInsets.only(top: 2,bottom: 2),child: Text(_mLawyerList![index].mAddress.isNotEmpty?_mLawyerList![index].mAddress:"-",style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis)),
        Padding(padding: const EdgeInsets.only(top: 2,bottom: 4),child: Text(_mLawyerList![index].mState.isNotEmpty?_mLawyerList![index].mState:"-",style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis)),
      ]),flex: 2),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.end,children: const [
        Icon(FontAwesomeIcons.phoneVolume,color: Colors.blueAccent,size: 25,)
      ]))
    ],);
  }

  status(){
    return  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      Expanded(child: Row(children: [
        Container(padding: const EdgeInsets.only(left: 2.5,right : 2.5),child: const Text("Status",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),),color: Colors.green,),
        const SizedBox(width: 5),
        const Text("Dispatched",style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold),)
      ],)),
      const Icon(Icons.more_vert_sharp,color: Colors.blueAccent,size: 30,),
    ]);
  }

  orderId(int id){
    return Row(children: [
      const Icon(Icons.note_alt_sharp,color: Colors.grey,size: 14,),
      const SizedBox(width: 2,),
      Expanded(child: Text("Order ID: $id",style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.bold),maxLines: 2,)),
    ],);
  }

  time(String hrs){
    return Row(children: [
      const Icon(Icons.lock_clock,color: Colors.grey,size: 14,),
      const SizedBox(width: 2,),
      Text(hrs.isNotEmpty?hrs:"-",style:const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.bold),maxLines: 2,),
    ],);
  }

  ecommerceLogo(){
    return Padding(padding: const EdgeInsets.only(left: 50,right: 50),child: Image.asset(AssetConstants.eCommerceLogo,height: 100,width: double.maxFinite,fit: BoxFit.fill));
  }

  @override
  showProgress({bool isLoading = true}) {
    setState(() {
      mLoading=isLoading;
    });
  }

  @override
  showToast(String toast) {
    CustomFlutterToast.showToast(toast);
  }

  void navigateToLoginView() {
    CustomNavigationUtils.pushAndRemoveUntil(context, const LoginView());
  }

  void setOrderDetails(List<GetLawyerDetailsModel> lawyerList) {
    _mLawyerList=lawyerList;
  }
}
