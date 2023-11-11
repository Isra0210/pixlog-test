import 'package:flutter/material.dart';

class HighlightTextInlineWidget extends StatelessWidget {
  const HighlightTextInlineWidget({
    required this.label,
    this.description,
    super.key,
  });

final String label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
