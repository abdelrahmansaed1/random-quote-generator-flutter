import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../features/quote/data/datasources/quote_remote_data_source.dart';
import '../../features/quote/data/repositories/quote_repository_impl.dart';
import '../../features/quote/domain/repositories/quote_repository.dart';
import '../../features/quote/domain/usecases/get_random_quote.dart';
import '../../features/quote/presentation/providers/quote_provider.dart';

/// Global Service Locator instance. Call setupDependencies() once
/// in main() before runApp(), then access anything registered here
/// via sl<TypeName>() from anywhere in the app.
final sl = GetIt.instance;

/// Wires the layers together:
///
///   DioClient
///     -> QuoteRemoteDataSource
///       -> QuoteRepository
///         -> GetRandomQuote (use case)
///           -> QuoteProvider (presentation state)
Future<void> setupDependencies() async {
  // ---------------- Core ----------------
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ---------------- Data layer ----------------
  sl.registerLazySingleton<QuoteRemoteDataSource>(
    () => QuoteRemoteDataSourceImpl(sl<DioClient>()),
  );

  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(sl<QuoteRemoteDataSource>()),
  );

  // ---------------- Domain layer ----------------
  sl.registerLazySingleton<GetRandomQuote>(
    () => GetRandomQuote(sl<QuoteRepository>()),
  );

  // ---------------- Presentation layer ----------------
  sl.registerFactory<QuoteProvider>(() => QuoteProvider(sl<GetRandomQuote>()));
}
