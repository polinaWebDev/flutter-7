import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import 'posts_wm.dart';
import 'widgets/post_card.dart';

class PostsScreen extends ElementaryWidget<IPostsWidgetModel> {
  const PostsScreen({
    super.key,
    WidgetModelFactory wmFactory = postsWidgetModelFactory,
  }) : super(wmFactory);

  @override
  Widget build(IPostsWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(title: const Text('Посты')),
      body: EntityStateNotifierBuilder<List<Post>>(
        listenableEntityState: wm.postsState,
        loadingBuilder: (_, _) =>
            const Center(child: CircularProgressIndicator()),
        errorBuilder: (_, error, _) => _ErrorView(
          message: error?.toString() ?? 'Что-то пошло не так',
          onRetry: wm.reload,
        ),
        builder: (_, posts) {
          final items = posts ?? const <Post>[];
          if (items.isEmpty) {
            return const Center(child: Text('Постов нет'));
          }
          return RefreshIndicator(
            onRefresh: () async => wm.reload(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              itemBuilder: (_, i) => PostCard(post: items[i]),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Повторить')),
          ],
        ),
      ),
    );
  }
}
