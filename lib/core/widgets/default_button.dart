import 'package:flutter/material.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

Widget defaultButton({
  required Function() event,
  required Widget text
})=>TextButton(
    onPressed: event,
    style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorsManager.primaryColor),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all(
            const Size(double.infinity,52)
        ),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
            )
        )
    ),
    child: text
);