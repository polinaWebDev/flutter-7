import 'package:dio/dio.dart';

import '../models/post_model.dart';

//своя ошибка чтобы наружу шел норм текст а не весь DioException
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

//ходим в сеть через dio и отдаем PostModel
class PostsRemoteDataSource {
  final Dio _dio;

  PostsRemoteDataSource([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://jsonplaceholder.typicode.com',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _dio.get<List<dynamic>>('/posts');
      final data = response.data ?? [];
      return data
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(_describeError(e));
    }
  }

  //маппинг типа ошибки dio в нормальное сообщение
  String _describeError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Превышено время ожидания, проверь соединение';
      case DioExceptionType.connectionError:
        return 'Нет соединения с сервером';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        return 'Сервер вернул ошибку${code != null ? ' ($code)' : ''}';
      default:
        return 'Не удалось загрузить посты';
    }
  }
}
