import '../entities/post.dart';
import '../repositories/posts_repository.dart';

//юзкейс, просто берем список постов
class GetPosts {
  final PostsRepository _repository;

  GetPosts(this._repository);

  Future<List<Post>> call() => _repository.getPosts();
}
