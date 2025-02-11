class ProductModel {
  String? brand;
  String? capacity;
  String? color;
  String? dimensions;
  int? id;
  String? image;
  String? installation;
  String? lockType;
  String? name;
  String? price;

  ProductModel(
    this.brand,
    this.capacity,
    this.color,
    this.dimensions,
    this.id,
    this.image,
    this.installation,
    this.lockType,
    this.name,
    this.price,
  );

  ProductModel.fromJson(Map<String, dynamic>? json) {
    brand = json?["brand"];
    capacity = json?["capacity"];
    color = json?["color"];
    dimensions = json?["dimensions"];
    id = json?["id"];
    image = json?["image"];
    installation = json?["installation"];
    lockType = json?["lockType"];
    name = json?["name"];
    price = json?["price"];
  }

  Map<String, dynamic> toMap() {
    return {
      "brand": brand,
      "capacity": capacity,
      "color": color,
      "dimensions": dimensions,
      "id": id,
      "image": image,
      "installation": installation,
      "lockType": lockType,
      "name": name,
      "price": price,
    };
  }
}
