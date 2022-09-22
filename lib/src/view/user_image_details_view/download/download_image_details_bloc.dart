import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:fss_interview/src/view/user_image_details_view/download/download_image_details_view.dart';

class DownloadImageDetailsBloc{
  late DownloadImageDetailsViewState _mView;

  setView(DownloadImageDetailsViewState view){
    _mView=view;
  }

  getUploadedImage() async{
    final Directory _directory = await getApplicationDocumentsDirectory();
    final Directory _appDirectory= Directory("${_directory.path}/zaigo");
    if (await _appDirectory.exists()) {
      _mView.setFileDetailsList(_appDirectory.listSync(recursive: true, followLinks: true));
    }
    _mView.showProgress(isLoading: false);
  }

}