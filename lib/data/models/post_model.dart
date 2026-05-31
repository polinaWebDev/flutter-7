import '../../domain/entities/post.dart';

typedef JsonMap = Map<String, dynamic>;

//тот же пост, только умеет в json
class PostModel extends Post {
  const PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(JsonMap json) => PostModel(
    userId: json['userId'] as int,
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
  );

  JsonMap toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'body': body,
  };
}
