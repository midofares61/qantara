import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/routing/router.dart';
import 'package:qantara/core/theming/colors.dart';

import '../../../core/di/cubit/cubit.dart';
import '../../../core/di/cubit/states.dart';
import '../../../core/theming/styles.dart';
class TalabatTab extends StatelessWidget {
  const TalabatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp,StateApp>(
        listener: (context,state){
    },
    builder:  (context,state){
      var cubit=CubitApp.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("الطلبات",style: TextStyles.font20BlackBold ,),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0.h,horizontal: 20.w),
          child:ConditionalBuilder(
              condition: cubit.orders!=null,
              builder: (context)=>ConditionalBuilder(
                  condition: cubit.orders!.isNotEmpty,
                  builder: (context)=>ListView.separated(
                      itemBuilder: (context,index)=>InkWell(
                        onTap: (){
                          context.pushNamed(Routes.pricing,arguments: cubit.orders![index]);
                        },
                        child: Container(
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
                              Image.asset(cubit.orders![index].image!,width: 80.w,fit: BoxFit.cover,),
                              Expanded(child: Column(
                                spacing: 15.h,
                                children: [
                                  Row(
                                    spacing: 10.w,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          spacing: 5.h,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(cubit.orders![index].name!,style: TextStyles.font18BlackBold,),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(cubit.orders![index].brand!,style: TextStyles.font12GreyReg,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: cubit.orders![index].status=="جاري التسعير"||cubit.orders![index].status=="تم التسعير"?ColorsManager.secondPrimaryColor:ColorsManager.greenColor,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,child: Text(cubit.orders![index].status!,style: cubit.orders![index].status=="جاهز للدفع"?TextStyles.font16GreenRegular:TextStyles.font16BrownRegular,)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(width: double.infinity,height: 1,color: Colors.grey.shade300,),
                                  Row(
                                    children: [
                                      Column(
                                        spacing: 5.h,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("تاريخ الطلب",style: TextStyles.font18BlackBold,),
                                          Text(cubit.orders![index].dateTime!.split(" ")[0],style: TextStyles.font14GreyReg,),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        spacing: 5.h,
                                        children: [
                                          Text("رقم الطلب",style: TextStyles.font18BlackBold,),
                                          Text(cubit.orders![index].id!.substring(0,12),style: TextStyles.font14GreyReg,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("التسعيرات",style: TextStyles.font18BlackBold),
                                      Text("${cubit.orders![index].number!}",style: TextStyles.font14GreyReg),
                                    ],
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context,index)=>SizedBox(height: 30.h,),
                      itemCount: cubit.orders!.length
                  ),
                  fallback: (context)=>Center(
                    child: Text("لا يوجد طلبات حالية",style: TextStyles.font20BlackBold,),
                  )
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),)
          ),
        ),
      ),
    );});
  }
}
