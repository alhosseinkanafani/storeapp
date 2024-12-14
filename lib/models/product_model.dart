class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel? rating;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      this.rating});

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      id: jsonData['id'],
      title: jsonData['title'],
      price: double.tryParse(jsonData['price'].toString()) ?? 0.0,
      description: jsonData['description'],
      category: jsonData['category'],
      image: jsonData['image'],
      rating: jsonData['rating'] != null
          ? RatingModel.fromJson(jsonData['rating'])
          : null,
    );
  }
}

class RatingModel {
  final double rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> jsonData) {
    return RatingModel(
        rate: double.tryParse(jsonData['rate'].toString()) ?? 0.0,
        count: jsonData['count']);
  }
}
