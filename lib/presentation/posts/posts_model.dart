import 'package:elementary/elementary.dart';

import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts.dart';

//логика экрана, просто дергает юзкейс
class PostsModel extends ElementaryModel {
  final GetPosts _getPosts;

  PostsModel(this._getPosts);

  Future<List<Post>> loadPosts() => _getPosts();
}
