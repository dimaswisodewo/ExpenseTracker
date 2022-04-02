import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatIconButton extends StatelessWidget {
  final IconData iconData;
  final void Function() handler;

  const AdaptiveFlatIconButton({
    Key? key,
    required this.iconData,
    required this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Icon(
                iconData,
                // size: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: handler,
          )
        : TextButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Icon(
                iconData,
                // size: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: handler,
          );
  }
}
