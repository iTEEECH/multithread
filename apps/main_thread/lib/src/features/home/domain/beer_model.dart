class Beer {
  final int id;
  final String name;
  final String brand;
  final String type;
  final String country;

  Beer({required this.id, required this.name, required this.brand, required this.type, required this.country});

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      type: json['type'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
