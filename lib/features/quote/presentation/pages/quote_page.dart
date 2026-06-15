import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/quote_provider.dart';
import '../widgets/quote_card.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  @override
  void initState() {
    super.initState();
    // Fetch a quote as soon as the app opens.
    // addPostFrameCallback ensures the provider is ready before we call it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuoteProvider>().fetchRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Container(
                padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.18),
                  ),
                ),
                child: Consumer<QuoteProvider>(
                  builder: (context, provider, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'QUOTE OF THE MOMENT',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 32),

                        _buildContent(provider),

                        const SizedBox(height: 40),

                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: provider.status == QuoteStatus.loading
                                  ? null
                                  : () => provider.fetchRandomQuote(),
                              child: const Text('New Quote'),
                            ),
                            const SizedBox(width: 16),
                            if (provider.quoteCount > 0)
                              Text(
                                '#${provider.quoteCount}',
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Renders the correct widget for the current QuoteStatus.
  Widget _buildContent(QuoteProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 140),
        child: switch (provider.status) {
          QuoteStatus.initial || QuoteStatus.loading => const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CircularProgressIndicator(
                color: AppColors.gold,
                strokeWidth: 2,
              ),
            ),
          ),
          QuoteStatus.loaded => QuoteCard(quote: provider.quote!),
          QuoteStatus.error => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                provider.errorMessage ?? 'Something went wrong.',
                style: const TextStyle(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        },
      ),
    );
  }
}
