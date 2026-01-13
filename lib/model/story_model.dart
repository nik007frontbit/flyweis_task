import 'reel_model.dart';

class StoryModel {
  int? id;
  String? title;
  String? discription;
  List<String>? image;
  String? emozi;
  List<String>? videoUrl;
  String? coverImage;
  bool? status;
  String? createdAt;
  Author? author; // Reusing Author from ReelModel

  StoryModel(
      {this.id,
      this.title,
      this.discription,
      this.image,
      this.emozi,
      this.videoUrl,
      this.coverImage,
      this.status,
      this.createdAt,
      this.author});

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['Real_Post_id'];
    title = json['title'];
    discription = json['Discription'];
    if (json['image'] != null) {
      if (json['image'] is List) {
        image = List<String>.from(json['image']);
      } else if (json['image'] is String) {
          // potential string handling
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
    data['VideoUrl'] = this.videoUrl ?? [];
    data['Coverimage'] = this.coverImage ?? "";
    data['Status'] = this.status;
    return data;
  }
}
