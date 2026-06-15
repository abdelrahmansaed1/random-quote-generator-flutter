import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qoute_app/core/errors/failure.dart';
import 'package:qoute_app/features/quote/data/datasources/quote_remote_data_source.dart';
import 'package:qoute_app/features/quote/domain/entities/quote.dart';
import 'package:qoute_app/features/quote/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    try {
      final quoteModel = await remoteDataSource.getRandomQuote();
      return Right(quoteModel);
    } on DioException catch (e) {
      return Left(_mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Failure _mapDioExceptionToFailure(DioException e) {
    switch (e.type) {
      case DioException.connectionTimeout:
      case DioException.sendTimeout:
      case DioException.receiveTimeout:
        return const TimeoutFailure();

      case DioExceptionType.connectionError:
        return const ConnectionFailure();

      case DioExceptionType.badResponse:
        return ServerFailure(
          'Server error (${e.response?.statusCode ?? 'unknown'}). Please try again.',
        );

      default:
        return const UnknownFailure();
    }
  }
}
