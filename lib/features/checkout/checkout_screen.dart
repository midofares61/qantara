import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qantara/core/di/models/price_model.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';

import '../../core/di/cubit/cubit.dart';
import '../../core/di/cubit/states.dart';
import '../../core/di/models/order_model.dart';
import '../../core/routing/router.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key,required this.order});
  PriceModel order;
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
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
            child: Column(
              spacing: 30.h,
              children: [
                Text("بيانات الطلب",style: TextStyles.font20BlackBold,),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w,vertical: 25.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300,width: 1),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 1),
                        color: Colors.grey.shade300
                      )
                    ]
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 10.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.name!,style: TextStyles.font18BlackBold,),
                            Text(order.brand!,style: TextStyles.font12GreyReg,),
                            Text("${order.price} SR",style: TextStyles.font18BlackBold,),
                          ],
                        ),
                      ),
                      Image.asset(order.image!),
                    ],
                  ),
                ),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 30.0.w,vertical: 25.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300,width: 1),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 1),
                            color: Colors.grey.shade300
                        )
                      ]
                  ),
                  child: Column(
                    spacing: 10.h,
                    children: [
                      listTile(title: 'صاحب الطلب', name: cubit.user!.firstName!),
                      listTile(title: 'رقم الجوال', name: cubit.user!.phone!),
                      listTile(title: 'وقت الطلب', name: order.dateTime!.split(" ")[0]),
                      listTile(title: 'السعر (شامل الضربية)', name: '${order.price}'),
                      listTile(title: 'الضربية المضافة', name: '15%'),
                      listTile(title: 'رسوم التوصيل', name: '30  SR'),
                      SizedBox(height: 20.h,),
                      Container(width: double.infinity,height: 1,color: Colors.grey.shade300,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("السعر الكلي لإجمالي الطلب",style: TextStyles.font14GreyReg,),
                          Text("${(int.parse(order.price!)*1.15)+30} SR",style: TextStyles.font16BlackReg),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Container(width: double.infinity,height: 1,color: Colors.grey.shade300,),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          // context.pushNamed(Routes.checkout);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorsManager.secondPrimaryColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                          child: Text("ادفع الآن",style: TextStyles.font16BrownRegular,),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );});
  }
  Widget listTile({
    required String title,
    required String name,
})=>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,style: TextStyles.font14GreyReg,),
      Text(name,style: TextStyles.font16BlackReg),
    ],
  );
}
