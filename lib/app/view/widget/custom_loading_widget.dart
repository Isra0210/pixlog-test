import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 22),
      alignment: Alignment.topCenter,
      child: const CircularProgressIndicator(),
    );
  }
}
