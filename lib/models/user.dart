class User {
  late String accessToken;
  UserInfo? userInfo;

  User({required this.accessToken, this.userInfo});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userInfo = json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['access_token'] = accessToken;
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? name;
  String? mobileNo;

  UserInfo({
    this.name,
    this.mobileNo,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNo = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['phone'] = mobileNo;
    return data;
  }
}
