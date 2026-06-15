import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/quote.dart';

/// A reusable, self-contained widget that renders a single Quote.
/// Kept separate from QuotePage so it could be reused elsewhere
/// (e.g. a "favorites" screen later) without duplication.
class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: Column(
        key: ValueKey(
          quote.content,
        ), // forces AnimatedSwitcher to animate on change
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('"${quote.content}"', style: theme.textTheme.bodyLarge),
          const SizedBox(height: 28),
          Container(width: 36, height: 1, color: AppColors.goldDim),
          const SizedBox(height: 16),
          Text('— ${quote.author}', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
