import 'package:qoute_app/features/quote/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({required super.content, required super.author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      content: json['quote'] as String? ?? '',
      author: json['author'] as String? ?? 'Unknown',
    );
  }
}
