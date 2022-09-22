class GetLawyerDetailsModel{
  late int mId;
  late String mName;
  late String mAddress;
  late String mState;
  late String mFieldOfExpertise;
  late String mLevel;
  late String mHoursLogged;
  late String mPhone;
  late String mEmail;
  late String mProfilePicture;

  GetLawyerDetailsModel.fromJson(Map<String, dynamic> json) {
    mId = json['id'];
    mName = json['name'];
    mAddress = json['address'];
    mState = json['state'];
    mFieldOfExpertise = json['field_of_expertise'];
    mLevel = json['level'];
    mHoursLogged = json['hours_logged'];
    mPhone = json['phone_no'];
    mEmail = json['email'];
    mProfilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = mId;
    data['name'] = mName;
    data['address'] = mAddress;
    data['state'] = mState;
    data['field_of_expertise'] = mFieldOfExpertise;
    data['level'] = mLevel;
    data['hours_logged'] = mHoursLogged;
    data['phone_no'] = mPhone;
    data['email'] = mEmail;
    data['profile_picture'] = mProfilePicture;
    return data;
  }

}