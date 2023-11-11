import 'package:flutter/material.dart';

import '../../resource/view/widget/highlight_text_inline_widget.dart';

class CustomFilterCardWidget extends StatelessWidget {
  const CustomFilterCardWidget({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outline,
            blurRadius: 0.8,
            spreadRadius: 0.8,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HighlightTextInlineWidget(
            label: "",
            description: label,
          ),
        ],
      ),
    );
  }
}
