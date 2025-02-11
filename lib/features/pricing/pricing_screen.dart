import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qantara/core/di/models/order_model.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';

import '../../core/di/cubit/cubit.dart';
import '../../core/di/cubit/states.dart';
import '../../core/routing/router.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
class PricingScreen extends StatefulWidget {
  PricingScreen({super.key,required this.order});
  OrderModel order;

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CubitApp.get(context).getPrice(widget.order.id!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp,StateApp>(
        listener: (context,state){

    },
    builder:  (context,state){
    var cubit=CubitApp.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            spacing: 30.h,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300,width: 1)
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 5.h,
                      children: [
                        Text(widget.order.name!,style: TextStyles.font18BlackBold,),
                        Text(widget.order.brand!,style: TextStyles.font12GreyReg),
                        // Text("الفئة / توجيلا",style: TextStyles.font12GreyReg),
                      ],
                    ),
                    Image.asset(widget.order.image!),
                    Container(
                      decoration: BoxDecoration(
                          color:  widget.order.status=="جاري التسعير"||widget.order.status=="تم التسعير"?ColorsManager.secondPrimaryColor:ColorsManager.greenColor,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                      child: Text(widget.order.status!,style:  widget.order.status=="جاهز للدفع"?TextStyles.font16GreenRegular:TextStyles.font16BrownRegular,),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ConditionalBuilder(
                      condition: cubit.pricing!=null,
                      builder: (context)=>ConditionalBuilder(
                          condition: cubit.pricing!.isNotEmpty,
                          builder: (context)=>ListView.separated(
                              itemBuilder: (context,index)=>Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300,width: 1),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  spacing: 20.w,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(cubit.pricing![index].image!),
                                    Expanded(child: Column(
                                      spacing: 20.h,
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("تسعيرة # ${index+1}",style: TextStyles.font18BlackBold,),
                                              Text(cubit.pricing![index].dateTime!.split(" ")[0],style: TextStyles.font14GreyReg,),

                                            ],
                                          ),
                                        ),
                                        Container(width: double.infinity,height: 1,color: Colors.grey.shade300,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              spacing: 5.h,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("الحالة",style: TextStyles.font18BlackBold,),
                                                Text("مستخدم أصلي",style: TextStyles.font14GreyReg,),
                                              ],
                                            ),
                                            Column(
                                              spacing: 5.h,
                                              children: [
                                                Text("السعر",style: TextStyles.font18BlackBold,),
                                                Text(cubit.pricing![index].price!,style: TextStyles.font14GreyReg,),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          spacing: 20,
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                context.pushNamed(Routes.checkout,arguments:cubit.pricing![index] );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsManager.greenColor,
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                                                child: Text("جاهز للدفع",style: TextStyles.font16GreenRegular,),
                                              ),
                                            ),
                                            SvgPicture.asset("assets/images/arrow.svg",width: 20,height: 20,)
                                          ],
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              separatorBuilder:  (context,index)=>SizedBox(height: 20.h,),
                              itemCount: cubit.pricing!.length
                          ),
                          fallback: (context)=>Center(
                            child: Text("لا يوجد تسعيرات حالية",style: TextStyles.font20BlackBold,),
                          )),
                      fallback: (context)=>Center(
                        child: CircularProgressIndicator(),
                      ),
                  )),
              SizedBox(height: 10.h,)
            ],
          ),
        ),
      ),
    );});
  }
}
