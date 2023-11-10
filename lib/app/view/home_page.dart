import 'package:flutter/material.dart';
import 'package:pixlogtest/app/view/widget/custom_error_message_widget.dart';
import 'package:pixlogtest/app/view/widget/custom_language_card_widget.dart';
import 'package:pixlogtest/app/view/widget/custom_loading_widget.dart';
import 'package:provider/provider.dart';

import '../controller/intl_resource_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const route = "/";

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<IntlResourceController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Linguagens disponíveis",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: FutureBuilder<List>(
        future: controller.getAvailableLanguages(),
        builder: (context, snapshot) {
          if (snapshot.hasError || controller.errorText.isNotEmpty) {
            return CustomErrorMessageWidget(messageError: controller.errorText);
          }

          if (Provider.of<IntlResourceController>(context, listen: false)
              .isLoading) {
            return const Column(
              children: [
                CustomLoadingWidget(),
                CustomErrorMessageWidget(
                  messageError:
                      "Estamos configurando o app, isso pode levar algum tempo.",
                )
              ],
            );
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: "Buscar",
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
                      Provider.of<IntlResourceController>(context,
                              listen: false)
                          .onSearchLanguage(value);
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...controller.languages.map(
                          (language) => GestureDetector(
                            onTap: () async {
                              await controller
                                  .getResourcesByLanguageId(language);
                            },
                            child: CustomLanguageCardWidget(
                              language: language.toString().toUpperCase(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          // }
        },
      ),
    );
  }
}
