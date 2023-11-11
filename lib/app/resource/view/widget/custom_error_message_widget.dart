import 'package:flutter/material.dart';

class CustomErrorMessageWidget extends StatelessWidget {
  const CustomErrorMessageWidget({this.messageError, super.key});

  final String? messageError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 22),
      alignment: Alignment.topCenter,
      child: Text(
        messageError ?? "Algo deu errado",
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
