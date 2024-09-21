class MemberModel {
  final String? email;
  final String? role;
  final String? image;
  final String? name;
  final String? accessToken;
  final String? memberId;
  final String? isMember;

  MemberModel({
    required this.email,
    required this.role,
    required this.image,
    required this.name,
    required this.accessToken,
    required this.memberId,
    required this.isMember,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      email: json['email'],
      role: json['role'],
      image: json['image'],
      name: json['name'],
      accessToken: json['accessToken'],
      memberId: json['memberId'],
      isMember: json['isMember'],
    );
  }
}
