import 'package:flutter/material.dart';
import 'package:pixlogtest/app/filter/widget/resource_details_by_filter.dart';
import 'package:pixlogtest/app/resource/controller/intl_resource_controller.dart';
import 'package:provider/provider.dart';

import '../widget/custom_filter_card_widget.dart';

class FilterListView extends StatefulWidget {
  const FilterListView({super.key});

  static const route = "filter";

  @override
  State<FilterListView> createState() => _FilterListViewState();
}

class _FilterListViewState extends State<FilterListView> {
  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<IntlResourceController>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Filtrar",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: "Linguagens"),
                Tab(text: "Modules"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: controller.languages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResourceDetailsByFilter(
                                filter: controller.languages[index],
                              ),
                            ),
                          );
                        },
                        child: CustomFilterCardWidget(
                          label: controller.languages[index],
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: controller.modules.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResourceDetailsByFilter(
                                filter: controller.modules[index],
                                isLanguageList: false,
                              ),
                            ),
                          );
                        },
                        child: CustomFilterCardWidget(
                          label: controller.modules[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
