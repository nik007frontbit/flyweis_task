class ReelModel {
  int? id;
  String? title;
  String? discription; // API nomenclature
  List<String>? image;
  String? emozi;
  List<String>? videoUrl;
  String? coverImage;
  bool? status;
  String? reelType;
  String? createdAt;
  Author? author;

  ReelModel(
      {this.id,
      this.title,
      this.discription,
      this.image,
      this.emozi,
      this.videoUrl,
      this.coverImage,
      this.status,
      this.reelType,
      this.createdAt,
      this.author});

  ReelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['Real_Post_id'];
    title = json['title'];
    discription = json['Discription'];
    if (json['image'] != null) {
      if (json['image'] is List) {
        image = List<String>.from(json['image']);
      } else if (json['image'] is String) {
        // Handle potential string case if API is inconsistent, though Postman says array
         // For now assume strictly list based on valid JSON, but be defensive if needed? 
         // Postman sample says: "image": ["https://example.com/image.jpg"]
      }
    }
    emozi = json['emozi'];
    if (json['VideoUrl'] != null) {
       if (json['VideoUrl'] is List) {
        videoUrl = List<String>.from(json['VideoUrl']);
      }
    }
    coverImage = json['Coverimage'];
    status = json['Status'];
    reelType = json['ReelType'];
    createdAt = json['created_at'];
    author = (json['author'] != null) 
        ? Author.fromJson(json['author']) 
        : (json['created_by'] != null) 
            ? Author.fromJson(json['created_by']) 
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['Discription'] = this.discription;
    data['image'] = this.image;
    data['emozi'] = this.emozi;
    data['VideoUrl'] = this.videoUrl;
    data['Coverimage'] = this.coverImage;
    data['Status'] = this.status;
    data['ReelType'] = this.reelType;
    return data;
  }
}

class Author {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;

  Author({this.id, this.firstName, this.lastName, this.profileImage});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileImage = json['profileImage'];
  }
}
