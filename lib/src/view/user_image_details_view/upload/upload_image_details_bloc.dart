import 'dart:io';
import 'package:fss_interview/src/view/user_image_details_view/upload/upload_image_details_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';

class UploadImageDetailsBloc{
  final ImagePicker _mPicker=ImagePicker();
  late UploadImageDetailsViewState _mView;

  setView(UploadImageDetailsViewState view){
   _mView=view;
  }

  uploadImage() async{
    bool isGranted=await checkPermission();
    if(isGranted){
      final XFile? pickedFile = await _mPicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100
      );
      if(pickedFile!=null) {
        saveInStorage(pickedFile.name,File(pickedFile.path),pickedFile.path.split(".").last);
      }
    }
  }

  Future saveInStorage(String fileName, File file, String extension) async {
    bool isGranted=await checkPermission();
    if(isGranted){
      String directory =await getInAppDocDir();
      File fileDef = File("$directory$fileName");
      await fileDef.create(recursive: true);
      Uint8List bytes = await file.readAsBytes();
      await fileDef.writeAsBytes(bytes);
      _mView.showToast("Uploaded successfully");
    }
  }

  Future<String> getInAppDocDir() async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder = Directory('${_appDocDir.path}/zaigo/');

    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder.path;
    } else {
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  Future<bool> checkPermission() async{
    var storageStatus = await Permission.storage.status;
    late Map<Permission, PermissionStatus>? statusMap;
    if (!storageStatus.isGranted) {
      statusMap= await [Permission.storage].request();
    }
    return await Permission.storage.status.isGranted;
  }


}