class GetLoginDetailsModel{
  late String mAccessToken;
  late String mName;

  GetLoginDetailsModel.fromJson(Map<String, dynamic> json) {
    mAccessToken = json['access_token'];
    mName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['access_token'] = mAccessToken;
    data['name'] = mName;
    return data;
  }
}