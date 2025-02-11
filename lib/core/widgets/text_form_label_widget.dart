import 'package:flutter/material.dart';
import 'package:qantara/core/theming/styles.dart';
Widget textFormLabelWidget({
  required String label,
  required bool obscure,
  Widget? icon,
  required TextEditingController controller,
  required String? Function(String?value) validate,
})=>Directionality(
  textDirection: TextDirection.rtl,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 5,
    children: [
      Text(label,style: TextStyles.font18BlackReg,),
      TextFormField(
        controller:controller,
        obscureText: obscure,
        validator: validate,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: icon??SizedBox()
        ),
      )
    ],
  ),
);
