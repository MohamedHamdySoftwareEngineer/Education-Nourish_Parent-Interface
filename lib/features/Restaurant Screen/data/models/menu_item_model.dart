class MenuItem {
  final String name, description, photo;

  MenuItem({
    required this.name,
    required this.description,
    required this.photo,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
    );
  }
}
