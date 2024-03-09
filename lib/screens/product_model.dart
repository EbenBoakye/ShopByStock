class Product {
  final String title;
  final String barcode;
  final String price;
  final String description;
  final String imageUrl;

  Product({
    required this.title,
    required this.barcode,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Optionally, you can include a factory method to create a Product instance from a JSON object:
  factory Product.fromJson(Map<String, dynamic> json) {
    // Assuming 'stores' and 'images' arrays might be empty and we provide default values
    String price = "N/A";
    if (json['stores'] != null && json['stores'].isNotEmpty) {
      price = json['stores'][0]['price'] ?? "N/A";
    }
    String imageUrl = "";
    if (json['images'] != null && json['images'].isNotEmpty) {
      imageUrl = json['images'][0];
    }

    return Product(
      title: json['title'],
      barcode: json['barcode_number'],
      price: price,
      description: json['description'],
      imageUrl: imageUrl,
    );
  }

  
}
