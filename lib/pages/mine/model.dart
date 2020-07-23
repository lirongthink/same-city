
class UserModel {
  String id;
  String nickname;
  String accout;
  String phone;
  String avatarUrl;
  String name;
  String address;
  double money;

  UserModel.fromJSON(Map data) {
    id = data['_id'];
    nickname = data['nickname'];
    accout = data['accout'];
    phone = data['phone'];
    avatarUrl = data['avatarUrl'];
    name = data['name'];
    address = data['address'];
    money = double.parse(data['money'].toString());
  }
}
