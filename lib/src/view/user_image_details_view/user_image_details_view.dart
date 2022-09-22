import 'package:fss_interview/src/view/user_image_details_view/download/download_image_details_view.dart';
import 'package:fss_interview/src/view/user_image_details_view/upload/upload_image_details_view.dart';
import 'package:flutter/material.dart';

class UserImageDetailsView extends StatefulWidget {
  const UserImageDetailsView({Key? key}) : super(key: key);

  @override
  State<UserImageDetailsView> createState() => UserImageDetailsViewState();
}

class UserImageDetailsViewState extends State<UserImageDetailsView> {
  int _mIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _mIndex,
        onTap: (int index) {
          setState(() {
            _mIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.upload,color: Colors.grey.shade400,size:30,),
            activeIcon:const Icon(Icons.upload,color: Colors.white,size: 35,),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image,color: Colors.grey.shade400,size:30,),
            activeIcon: const Icon(Icons.image,color: Colors.white,size: 35,),
            label: "Images",
          ),
        ]),
      body: _mIndex==1?const DownloadImageDetailsView():UploadImageDetailsView());
  }

}
