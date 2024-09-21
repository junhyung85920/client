class MemberDetail {
  final String? email;
  final String? role;
  final String? image;
  final String? name;

  MemberDetail({
    required this.email,
    required this.role,
    required this.image,
    required this.name,
  });

  factory MemberDetail.fromJson(Map<String, dynamic> json) {
    return MemberDetail(
        email: json['email'],
        role: json['role'],
        image: json['image'],
        name: json['name']);
  }
}

class Bookmark {
  final String popup_id;
  final String title;
  final DateTime start_date;
  final DateTime end_date;
  final String address;
  final String category;
  final String status;
  final String description;

  Bookmark({
    required this.popup_id,
    required this.title,
    required this.start_date,
    required this.end_date,
    required this.address,
    required this.category,
    required this.status,
    required this.description,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      popup_id: json['popup_id'],
      title: json['title'],
      start_date: DateTime.parse(json['start_date']),
      end_date: DateTime.parse(json['end_date']),
      address: json['address'],
      category: json['category'],
      status: json['status'],
      description: json['description'],
    );
  }
}
