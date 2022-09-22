import 'package:fss_interview/src/models/get_lawyer_details_model.dart';

class GetLawyerDetailsWrapper{
  late List<GetLawyerDetailsModel> mLawyerList;


  GetLawyerDetailsWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      mLawyerList = <GetLawyerDetailsModel>[];
      json['data'].forEach((v) {
        mLawyerList.add(GetLawyerDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['data'] = mLawyerList.map((v) => v.toJson()).toList();
    return data;
  }
}