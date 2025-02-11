import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/routing/router.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';

class OtbScreen extends StatefulWidget {
   OtbScreen({super.key,required this.verification});
String verification;
  @override
  State<OtbScreen> createState() => _OtbScreenState();
}

class _OtbScreenState extends State<OtbScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            spacing: 25.h,
            children: [
              SizedBox(height: 20.h,),
              SvgPicture.asset("assets/images/otb.svg"),
              Text(
                "تحقق من الرقم",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              Text(
                "الرجاء إدخال رمز التحقق الذي أرسلناه إلى رقم جوالك. لإتمام عملية التحقق",
                style: TextStyle(fontSize: 17.sp, color: Colors.grey,height: 1.8),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h,),
              Form(
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Pinput(
                      length: 6,
                      obscureText: true,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      onCompleted: (pin)async{
                        FirebaseAuth auth = FirebaseAuth.instance;

                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verification, smsCode: pin);
                          await auth.signInWithCredential(credential).then((value){
                            context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (Route<dynamic> route)=>false);
                          });
                        }catch(e){

                        }
                      } ,
                      defaultPinTheme: PinTheme(
                        width: 40,
                        height: 40,
                        textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  )
              ),
              SizedBox(height: 20.h,),
              TextButton(
                  onPressed: (){

                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: WidgetStateProperty.all(
                          const Size(double.infinity,52)
                      ),
                      shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.black,width: 1),
                          )
                      ),
                  ),
                  child: Text("اعادة ارسال رمز التحقق",style: TextStyles.font18BrownRegular,)
              )
            ],
          ),
        ),
      ),
    );
  }
}
