import 'package:flutter/material.dart';
import 'package:pixlogtest/app/model/intl_resource_model.dart';

import 'highlight_text_inline_widget.dart';

class CustomResourceCardWidget extends StatelessWidget {
  const CustomResourceCardWidget({required this.resource, super.key});

  final IntlResourceModel resource;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.22,
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
          HighlightTextInlineWidget(
            label: "Id",
            description: resource.languageId,
          ),
          HighlightTextInlineWidget(
            label: "Resource id",
            description: resource.resourceId,
          ),
          HighlightTextInlineWidget(
            label: "Module id",
            description: resource.moduleId,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HighlightTextInlineWidget(
                label: "Criado em",
                description: resource.createdAt.toString(),
              ),
              HighlightTextInlineWidget(
                label: "Atualizado em",
                description: resource.updatedAt.toString(),
              ),
            ],
          ),
          HighlightTextInlineWidget(
            label: "Valor",
            description: resource.value,
          ),
        ],
      ),
    );
  }
}
