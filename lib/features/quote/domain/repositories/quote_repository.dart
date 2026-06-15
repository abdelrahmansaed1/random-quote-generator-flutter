import 'package:dartz/dartz.dart';
import 'package:qoute_app/core/errors/failure.dart';
import 'package:qoute_app/features/quote/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
