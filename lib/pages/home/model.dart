
class HomeGoodModel {
  String id;
  double imageHeight;
  double imageWidth;
  String imageUrl;
  String describe;
  double price;
  String avatarUrl;
  String userName;
  String userId;

  HomeGoodModel.fromJSON(Map data) {
    id = data['_id'];
    imageHeight = double.parse(data['imageHeight'].toString());
    imageWidth = double.parse(data['imageWidth'].toString());
    imageUrl = data['imageUrl'];
    describe = data['describe'];
    price = double.parse(data['price'].toString());
    avatarUrl = data['user']['avatarUrl'];
    userName = data['user']['nickname'];
    userId = data['user']['_id'];
  }
}
