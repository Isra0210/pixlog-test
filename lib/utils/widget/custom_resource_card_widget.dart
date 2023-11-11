import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pixlogtest/app/resource/model/intl_resource_model.dart';

import '../../app/resource/view/widget/highlight_text_inline_widget.dart';

class CustomResourceCardWidget extends StatelessWidget {
  const CustomResourceCardWidget({required this.resource, super.key});

  final IntlResourceModel resource;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String formatDate(int dateAsInt) {
      final date = DateTime.fromMillisecondsSinceEpoch(dateAsInt);

      return DateFormat("yyyy/MM/dd").format(date);
    }

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outline,
            blurRadius: 0.8,
            spreadRadius: 0.8,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            resource.value ?? "",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: HighlightTextInlineWidget(
              label: "Resource id: ",
              description: resource.resourceId,
            ),
          ),
          resource.updatedAt == null
              ? const SizedBox()
              : HighlightTextInlineWidget(
                  label: "Atualizado em: ",
                  description: formatDate(resource.updatedAt!),
                ),
        ],
      ),
    );
  }
}
