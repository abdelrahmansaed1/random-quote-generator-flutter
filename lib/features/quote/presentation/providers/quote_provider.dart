import 'package:flutter/foundation.dart';
import 'package:qoute_app/core/errors/failure.dart';
import 'package:qoute_app/features/quote/domain/entities/quote.dart';
import 'package:qoute_app/features/quote/domain/usecases/get_random_quote.dart';

enum QuoteStatus { initial, loading, loaded, error }

class QuoteProvider extends ChangeNotifier {
  final GetRandomQuote getRandomQuote;
  QuoteProvider(this.getRandomQuote);

  QuoteStatus _status = QuoteStatus.initial;
  Quote? _quote;
  String? _errorMessage;
  int _quoteCount = 0;

  QuoteStatus get status => _status;
  Quote? get quote => _quote;
  String? get errorMessage => _errorMessage;
  int get quoteCount => _quoteCount;

  Future<void> fetchRandomQuote() async {
    _status = QuoteStatus.loading;
    notifyListeners();
    final result = await getRandomQuote();

    result.fold(
      (failure) {
        _status = QuoteStatus.error;
        _errorMessage = _mapFailureToMessage(failure);
      },
      (quote) {
        _status = QuoteStatus.loaded;
        _quote = quote;
        _errorMessage = null;
        _quoteCount++;
      },
    );

    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
