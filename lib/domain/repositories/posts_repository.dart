import '../entities/post.dart';

//просто интерфейс, а реализацию пишем в data
abstract interface class PostsRepository {
  Future<List<Post>> getPosts();
}
