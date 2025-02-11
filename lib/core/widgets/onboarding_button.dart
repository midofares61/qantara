import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qantara/core/theming/colors.dart';

import '../theming/styles.dart';

class OnBoardingButton extends StatelessWidget {
   OnBoardingButton({super.key,required this.event});
Function() event;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: event,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(ColorsManager.secondPrimaryColor),
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
        child: Text("التالي",style: TextStyles.font18BrownRegular,)
    );
  }
}
