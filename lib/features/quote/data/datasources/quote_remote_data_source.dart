import 'package:qoute_app/core/network/api_constants.dart';
import 'package:qoute_app/core/network/dio_client.dart';
import 'package:qoute_app/features/quote/data/models/quote_model.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final DioClient dioClient;

  QuoteRemoteDataSourceImpl(this.dioClient);

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await dioClient.get(ApiConstants.randomQuoteEndpoint);
    return QuoteModel.fromJson(response.data as Map<String, dynamic>);
  }
}
