import 'package:flutter/material.dart';
import 'package:pixlogtest/app/resource/controller/intl_resource_controller.dart';

import 'package:provider/provider.dart';

import '../../../utils/widget/custom_resource_card_widget.dart';

class ResourceDetailsByFilter extends StatelessWidget {
  const ResourceDetailsByFilter(
      {required this.filter, this.isLanguageList = true, super.key});

  final bool isLanguageList;

  final String filter;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<IntlResourceController>(context);

    final List resources = isLanguageList
        ? controller.groupedResourceListByLanguages[filter]
        : controller.groupedResourceListByModules[filter];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          filter,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return CustomResourceCardWidget(resource: resources[index]);
        },
      ),
    );
  }
}
