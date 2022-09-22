import 'package:flutter/material.dart';
import 'package:fss_interview/src/base/base_view.dart';
import 'package:fss_interview/src/helper/custom_flutter_toast.dart';
import 'package:fss_interview/src/view/user_image_details_view/upload/upload_image_details_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageDetailsView extends StatefulWidget {
  const UploadImageDetailsView({Key? key}) : super(key: key);

  @override
  State<UploadImageDetailsView> createState() => UploadImageDetailsViewState();
}

class UploadImageDetailsViewState extends State<UploadImageDetailsView> implements BaseView{
  late UploadImageDetailsBloc _mBloc;

  @override
  void initState() {
    init();
    super.initState();
  }

  init(){
    _mBloc=UploadImageDetailsBloc();
    _mBloc.setView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      Center(child: TextButton(child: const Text("Upload"),style: ButtonStyle(
          side: MaterialStateProperty.all(const BorderSide(
              color: Colors.blue,
              width: 1.0,
              style: BorderStyle.solid))),onPressed: (){
        _mBloc.uploadImage();
      })),
    ],);
  }

  @override
  showProgress({bool isLoading = true}) {

  }

  @override
  showToast(String toast) {
    CustomFlutterToast.showToast(toast);
  }
}
