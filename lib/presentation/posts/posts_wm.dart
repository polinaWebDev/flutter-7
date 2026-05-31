import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

import '../../data/datasources/posts_remote_data_source.dart';
import '../../data/repositories/posts_repository_impl.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts.dart';
import 'posts_model.dart';
import 'posts_screen.dart';

//собираем все слои для экрана
PostsWidgetModel postsWidgetModelFactory(BuildContext context) {
  final repository = PostsRepositoryImpl(PostsRemoteDataSource());
  final model = PostsModel(GetPosts(repository));
  return PostsWidgetModel(model);
}

//что wm отдает наружу, чтобы экран это юзал
abstract interface class IPostsWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Post>> get postsState;

  void reload();
}

class PostsWidgetModel extends WidgetModel<PostsScreen, PostsModel>
    implements IPostsWidgetModel {
  final _postsState = EntityStateNotifier<List<Post>>();

  PostsWidgetModel(super.model);

  @override
  EntityValueListenable<List<Post>> get postsState => _postsState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _load();
  }

  @override
  void reload() => _load();

  Future<void> _load() async {
    _postsState.loading();
    try {
      final posts = await model.loadPosts();
      _postsState.content(posts);
    } on Exception catch (e) {
      _postsState.error(e);
    }
  }

  @override
  void dispose() {
    _postsState.dispose();
    super.dispose();
  }
}
