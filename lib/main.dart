import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'features/quote/presentation/pages/quote_page.dart';
import 'features/quote/presentation/providers/quote_provider.dart';

Future<void> main() async {
  // Build the dependency graph BEFORE the app starts.
  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuoteProvider>(
          create: (_) => sl<QuoteProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Quote Generator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const QuotePage(),
      ),
    );
  }
}
