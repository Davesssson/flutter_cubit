class Item {
  int? id;
  String? name;
  String? description;
  double? price;
  String? color;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.color
  });

  Item.empty();

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      color: json['color'],

    );
  }

  Map<String, dynamic> toJson(Item product) {
    return {
      "id": product.id,
      "name": product.name,
      "description": product.description,
      "price": product.price,
      "color": product.color
    };
  }

  @override
  String toString() {
    return 'Item{id: $id,'
        ' name: $name,'
        ' description: $description,'
        ' price: $price},'
        ' color: $color}';
  }
}