import 'dart:io';
import 'package:fss_interview/src/base/base_view.dart';
import 'package:fss_interview/src/helper/custom_flutter_toast.dart';
import 'package:fss_interview/src/helper/custom_navigation_utils.dart';
import 'package:fss_interview/src/helper/custom_zoom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:fss_interview/src/view/user_image_details_view/download/download_image_details_bloc.dart';

class DownloadImageDetailsView extends StatefulWidget {
  const DownloadImageDetailsView({Key? key}) : super(key: key);

  @override
  State<DownloadImageDetailsView> createState() => DownloadImageDetailsViewState();
}

class DownloadImageDetailsViewState extends State<DownloadImageDetailsView> implements BaseView{
  late DownloadImageDetailsBloc _mBloc;
  List<FileSystemEntity>? _mFileList;
  bool _mLoading=true;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async{
    _mBloc=DownloadImageDetailsBloc();
    _mBloc.setView(this);
    await _mBloc.getUploadedImage();
  }

  @override
  Widget build(BuildContext context) {
    return _mLoading?Column(mainAxisAlignment: MainAxisAlignment.center,children: const [
      Center(child: CircularProgressIndicator(),)
    ],):(_mFileList!=null && _mFileList!.isNotEmpty)?GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: _mFileList!.length,
        itemBuilder: (BuildContext ctx, index) {
          return fileView(index);
        }):Column(mainAxisAlignment: MainAxisAlignment.center,children: const [
      Center(child: Text("No items uploaded"))
    ],);
  }

  fileView(index){
    return InkWell(child: Image.file(File(_mFileList![index].path),fit: BoxFit.cover,height: double.maxFinite,width: double.maxFinite,),onTap: (){
      navigateToImageView(_mFileList![index].path);
    });
  }



  @override
  showProgress({bool isLoading = true}) {
    setState(() => _mLoading=isLoading);
  }

  @override
  showToast(String toast) {
    CustomFlutterToast.showToast(toast);
  }

  navigateToImageView(String file){
    CustomNavigationUtils.push(context, CustomZoomImageView(fileImage: file));
  }

  void setFileDetailsList(List<FileSystemEntity> listSync) {
    _mFileList=listSync;
  }

}
