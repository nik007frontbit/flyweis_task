import 'reel_model.dart';

class CommentModel {
  int? id;
  int? realPostId;
  String? commentText;
  bool? status;
  String? createdAt;
  Author? commentBy;

  CommentModel(
      {this.id,
      this.realPostId,
      this.commentText,
      this.status,
      this.createdAt,
      this.commentBy});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    realPostId = json['Real_Post_id'];
    commentText = json['commentText'];
    status = json['Status'];
    createdAt = json['created_at'];
    commentBy = (json['comment_by'] != null && json['comment_by'] is Map)
        ? Author.fromJson(json['comment_by'])
        : (json['created_by'] != null && json['created_by'] is Map) // Fallback if API inconsistency
            ? Author.fromJson(json['created_by'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Real_Post_id'] = this.realPostId;
    data['commentText'] = this.commentText;
    data['Status'] = this.status;
    return data;
  }
}
