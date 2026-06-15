import 'package:dartz/dartz.dart';
import 'package:qoute_app/core/errors/failure.dart';
import 'package:qoute_app/features/quote/domain/entities/quote.dart';
import 'package:qoute_app/features/quote/domain/repositories/quote_repository.dart';

class GetRandomQuote {
  final QuoteRepository repository;

  GetRandomQuote(this.repository);

  Future<Either<Failure, Quote>> call() async {
    return await repository.getRandomQuote();
  }
}
