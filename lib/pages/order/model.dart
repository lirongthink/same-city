
class OrderModel {
  String id;
  String status;
  String goodId;
  String goodImage;
  String goodDescrip;
  double goodPrice;
  String sellerName;
  String sellerAvatarUrl;
  String sellerId;
  String buyerName;
  String buyerPhone;
  String buyerAddress;
  String buyerAvatarUrl;
  String buyerNickname;
  DateTime date;

  OrderModel.fromJSON(Map data) {
    id = data['_id'];
    status = data['status'];
    goodId = data['good']['_id'];
    goodDescrip = data['good']['describe'];
    goodPrice = double.parse(data['good']['price'].toString());
    goodImage = data['good']['imageUrl'];
    sellerName = data['seller']['nickname'];
    sellerId = data['seller']['_id'];
    sellerAvatarUrl = data['seller']['avatarUrl'];
    date = DateTime.parse(data['createdAt']);
    buyerName = data['buyer']['name'];
    buyerNickname = data['buyer']['nickname'];
    buyerPhone = data['buyer']['phone'];
    buyerAddress = data['buyer']['address'];
    buyerAvatarUrl = data['buyer']['avatarUrl'];
  }
}
