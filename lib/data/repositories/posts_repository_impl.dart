import '../../domain/entities/post.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/posts_remote_data_source.dart';

//реализуем интерфейс из domain, данные берем из remote
class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource _remote;

  PostsRepositoryImpl([PostsRemoteDataSource? remote])
    : _remote = remote ?? PostsRemoteDataSource();

  @override
  Future<List<Post>> getPosts() => _remote.getPosts();
}
