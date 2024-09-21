class PopUpModel {
  final String popup_id;
  final String title;
  final String description;
  final String start_date;
  final String end_date;
  final String category;
  final String image;
  final String status;
  final String address;

  PopUpModel({
    required this.popup_id,
    required this.title,
    required this.description,
    required this.start_date,
    required this.end_date,
    required this.category,
    required this.image,
    required this.status,
    required this.address,
  });

  factory PopUpModel.fromJson(Map<String, dynamic> json) {
    return PopUpModel(
      title: json['title'],
      popup_id: json['popup_id'],
      description: json['description'],
      end_date: json['end_date'],
      start_date: json['start_date'],
      category: json['category'],
      image: json['image'],
      status: json['status'],
      address: json['address'],
    );
  }
}
