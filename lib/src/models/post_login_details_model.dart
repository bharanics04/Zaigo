class PostLoginDetailsModel{
  late String mPhone;
  late String mPassword;

  PostLoginDetailsModel({required this.mPhone,required this.mPassword});

  PostLoginDetailsModel.fromJson(Map<String, dynamic> json) {
    mPhone = json['phone_no'];
    mPassword = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['phone_no'] = mPhone;
    data['password'] = mPassword;
    return data;
  }
}