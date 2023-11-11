import 'package:flutter/material.dart';
import 'package:pixlogtest/app/resource/model/intl_resource_model.dart';
import 'package:pixlogtest/app/resource/view/widget/custom_error_message_widget.dart';
import 'package:pixlogtest/utils/widget/custom_resource_card_widget.dart';
import 'package:provider/provider.dart';

import '../controller/intl_resource_controller.dart';
import '../../filter/view/filter_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const route = "/";

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<IntlResourceController>(context);

    Widget body() => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: "Buscar pelo resource id",
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    Provider.of<IntlResourceController>(
                      context,
                      listen: false,
                    ).onSearch(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.resources.length,
                  itemBuilder: (context, index) {
                    return CustomResourceCardWidget(
                      resource: controller.resources[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tradutor",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: controller.resources.isEmpty
            ? null
            : [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FilterListView.route);
                  },
                  icon: const Icon(Icons.filter_list),
                )
              ],
      ),
      body: controller.resources.isNotEmpty
          ? body()
          : FutureBuilder<List<IntlResourceModel>>(
              future: controller.getResources(),
              builder: (context, snapshot) {
                if (snapshot.hasError || controller.errorText.isNotEmpty) {
                  return CustomErrorMessageWidget(
                    messageError: controller.errorText.isEmpty
                        ? null
                        : controller.errorText,
                  );
                }

                if (controller.resources.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomErrorMessageWidget(
                          messageError:
                              "Configurando o app, isso pode levar algum tempo.",
                        ),
                        CustomErrorMessageWidget(messageError: "Carregando..."),
                      ],
                    ),
                  );
                }

                return body();
              }),
    );
  }
}
