import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/widgets/default_button.dart';

import '../../core/di/cubit/cubit.dart';
import '../../core/di/cubit/states.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  List<Map<String, dynamic>> cars = [
    {
      "name": "جيلي",
      "image": "assets/images/Geely.png",
      "list": [
        {
          "category": "توجيلا",
          "models": ["2022", "2023", "2024"]
        },
        {
          "category": "كول راي",
          "models": ["2021", "2022", "2023"]
        }
      ]
    },
    {
      "name": "بي ام دبليو",
      "image": "assets/images/bmw.png",
      "list": [
        {
          "category": "اكس 5",
          "models": ["2020", "2021", "2022", "2023"]
        },
        {
          "category": "اكس 6",
          "models": ["2019", "2020", "2021", "2022"]
        }
      ]
    },
    {
      "name": "فورد",
      "image": "assets/images/ford.png",
      "list": [
        {
          "category": "تورس",
          "models": ["2021", "2022", "2023"]
        },
        {
          "category": "اكسبلورر",
          "models": ["2020", "2021", "2022"]
        }
      ]
    },
    {
      "name": "تويوتا",
      "image": "assets/images/toyota.png",
      "list": [
        {
          "category": "كورولا",
          "models": ["2019", "2020", "2021", "2022", "2023"]
        },
        {
          "category": "لاندكروزر",
          "models": ["2020", "2021", "2022", "2023", "2024"]
        }
      ]
    },
    {
      "name": "مرسيدس",
      "image": "assets/images/mercedes.png",
      "list": [
        {
          "category": "سي كلاس",
          "models": ["2018", "2019", "2020", "2021", "2022"]
        },
        {
          "category": "اي كلاس",
          "models": ["2019", "2020", "2021", "2022", "2023"]
        }
      ]
    },
    {
      "name": "هيونداي",
      "image": "assets/images/hyundai.png",
      "list": [
        {
          "category": "النترا",
          "models": ["2020", "2021", "2022", "2023"]
        },
        {
          "category": "توسان",
          "models": ["2019", "2020", "2021", "2022"]
        }
      ]
    },
    {
      "name": "كيا",
      "image": "assets/images/kia.png",
      "list": [
        {
          "category": "سبورتاج",
          "models": ["2019", "2020", "2021", "2022", "2023"]
        },
        {
          "category": "سيراتو",
          "models": ["2018", "2019", "2020", "2021", "2022"]
        }
      ]
    }
  ];


  Map<String, dynamic>? brand;
  String? category;
  String? model;
  String number="";
TextEditingController controller=TextEditingController();
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
        title: Text("اضافة سيارة", style: TextStyles.font20BlackBold),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Container(
                  width: double.infinity,
                  height: 220.h,
                  padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: ColorsManager.greyBlackColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    spacing: 15.w,
                    children: [
                      brand != null
                          ? Image.asset(brand!["image"], width: 90.w)
                          : SizedBox(width: 90.w),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(number.isNotEmpty)
                                  Text("رقم الهيكل", style: TextStyles.font18WhiteBold),
                                  if(controller.text.isNotEmpty)
                                  Text(controller.text, style: TextStyles.font18GreyBold),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  category != null
                                      ?
                                  Column(
                                    children: [
                                       Text("الفئة", style: TextStyles.font18WhiteBold),
                                      Text(category ?? "اختر الفئة", style: TextStyles.font18GreyBold),
                                    ],
                                  ):SizedBox(),
                                  model != null
                                      ?
                                  Column(
                                    children: [
                                      Text("موديل", style: TextStyles.font18WhiteBold),
                                      Text(model ?? "اختر الموديل", style: TextStyles.font18GreyBold),
                                    ],
                                  ):SizedBox(),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                selectButtonImage(
                  label: 'نوع السيارة',
                  choose: brand?["name"],
                  list: cars,
                  onChange: (String? value) {
                    setState(() {
                      brand = cars.firstWhere((car) => car["name"] == value, orElse: () => {});
                      category = null;
                      model = null;
                    });
                  }, name: 'name',
                ),
                selectButtonImage(
                  label: 'فئة السيارة',
                  choose: category,
                  list: brand?["list"] ?? [],
                  onChange: (String? value) {
                    setState(() {
                      category = value;
                      model = null;
                    });
                  }, name: 'category',
                ),
                selectButton(
                  label: 'موديل السيارة',
                  choose: model,
                  list: brand != null && category != null
                      ? (brand?["list"] as List<dynamic>)
                      .firstWhere(
                        (item) => item["category"] == category,
                    orElse: () => {"models": []},
                  )["models"] ?? []
                      : [],
                  onChange: (String? value) {
                    setState(() {
                      model = value;
                    });
                  },
                ),
                Text("رقم الهيكل", style: TextStyles.font18BlackReg),
                TextFormField(
                  controller:controller,
                  onChanged: (value){
                    setState(() {
                      number=value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 10.h,),
                defaultButton(event: (){
                  cubit.insertData(brand: brand!["image"], category: category!, model: model!, number: number, name: brand!["name"]);
                  brand=null;
                  category=null;
                  model=null;
                  number="";
                  controller.text="";
                  context.pop();
                }, text: Text("تفعيل",style: TextStyles.font18BrownRegular,))
              ],
            ),
          ),
        ),
      ),
    );});
  }

  Widget selectButtonImage({
    required String label,
    required String name,
    String? choose,
    required List<Map<String, dynamic>> list,
    required Function(String? value) onChange,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          Text(label, style: TextStyles.font18BlackReg),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              isExpanded: true,
              underline: Container(),
              value: choose,
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              onChanged: onChange,
              items: list
                  .map<DropdownMenuItem<String>>((Map<String, dynamic> model) {
                return DropdownMenuItem<String>(
                  value: model[name],
                  child: Text(model[name]),
                );
              }).toList(),
            ),
          ),
        ],
      );

  Widget selectButton({
    required String label,
    String? choose,
    required List<String> list,
    required Function(String? value) onChange,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          Text(label, style: TextStyles.font18BlackReg),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              isExpanded: true,
              underline: Container(),
              value: choose,
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              onChanged: onChange,
              items: list
                  .map<DropdownMenuItem<String>>((String model) {
                return DropdownMenuItem<String>(
                  value: model,
                  child: Text(model),
                );
              }).toList(),
            ),
          ),
        ],
      );
}

