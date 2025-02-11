import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/widgets/default_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/di/cubit/cubit.dart';
import '../../core/di/cubit/states.dart';
import '../../core/routing/router.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key,required this.car});
  Map<String,dynamic>? car;
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController colorController=TextEditingController();
  TextEditingController notesController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp,StateApp>(
        listener: (context,state){
          if(state is SuccessAddOrderState){
            context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (Route<dynamic> route)=>false);
          }
    },
    builder:  (context,state){
    var cubit=CubitApp.get(context);
    return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("سعّرها معنا ", style: TextStyles.font20BlackBold),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 25.0.w),
                child: Text("المركبه",style: TextStyles.font20BlackBold,),
              ),
              Container(
                width: double.infinity,
                height: 180.h,
                padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
                decoration: BoxDecoration(
                    color: ColorsManager.greyBlackColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  spacing: 15.w,
                  children: [
                    Image.asset(widget.car!["brand"], width: 90.w),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("رقم الهيكل", style: TextStyles.font18WhiteBold),
                                Text(widget.car!["number"], style: TextStyles.font18GreyBold),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text("الفئة", style: TextStyles.font18WhiteBold),
                                    Text(widget.car!["category"], style: TextStyles.font18GreyBold),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("موديل", style: TextStyles.font18WhiteBold),
                                    Text(widget.car!["model"], style: TextStyles.font18GreyBold),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  Text("اسم القطعة أو رقمها",style: TextStyles.font18BlackBold,),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  ),
                  Text("لون القطعة ",style: TextStyles.font18BlackBold,),
                  TextFormField(
                    controller: colorController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                  ),
                  Text("صور",style: TextStyles.font18BlackBold,),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          cubit.picCategoryImageFromGallery();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300,width: 1),
                            borderRadius: BorderRadius.circular(6)
                          ),
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/images/camera.png"),
                        ),
                      )
                    ],
                  ),
                  Text("تفاصيل القطعة",style: TextStyles.font18BlackBold,),
                  TextFormField(
                    controller: notesController,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                  )
                ],
              ),
              defaultButton(event: (){
                cubit.addOrder(name: nameController.text, brand: '${widget.car!["name"]} / ${widget.car!["category"]} ${widget.car!["model"]}', color: colorController.text, notes:notesController.text, image: widget.car!["brand"]);}, text:Text("اطلب",style: TextStyles.font18BrownRegular,))
            ],
          ),
        ),
      ),
    ));});
  }
}
