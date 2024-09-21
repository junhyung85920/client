class BookmarkModel {
  final String bookmark_id;
  final String popup_id;
  final String title;
  final String description;
  final String start_date;
  final String end_date;
  final String address;
  final String category;
  final String status;
  final String image;

  BookmarkModel({
    required this.bookmark_id,
    required this.popup_id,
    required this.title,
    required this.description,
    required this.start_date,
    required this.end_date,
    required this.address,
    required this.category,
    required this.status,
    required this.image,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      bookmark_id: json['bookmark_id'],
      title: json['title'],
      popup_id: json['popup_id'],
      description: json['description'],
      end_date: json['end_date'],
      start_date: json['start_date'],
      address: json['address'],
      category: json['category'],
      status: json['status'],
      image: json['image'],
    );
  }
}
