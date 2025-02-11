import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/routing/router.dart';
import 'package:qantara/core/theming/colors.dart';
import 'package:qantara/features/login/logic/cubit/login_state.dart';
import 'package:qantara/features/login/otb_screen.dart';

import '../../core/theming/styles.dart';
import '../../core/widgets/default_button.dart';
import '../../core/widgets/logo_widget.dart';
import '../../core/widgets/text_form_label_widget.dart';
import 'logic/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController controller = PageController();
  bool check = false;
  var formLoginKeys=GlobalKey<FormState>();
  var formKeys=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if(state is RegisterSuccessState || state is LoginSuccessState){
                context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (Route<dynamic> route)=>false);
              }
            },
            builder: (context, state) {
              var cubit = LoginCubit.get(context);
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: Colors.white,
                  ),
                  body: SingleChildScrollView(
                    // لتفعيل التمرير
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                        child: Column(
                          children: [
                            logoWidget(),
                            TabBar(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              labelPadding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 8.h),
                              labelColor: ColorsManager.brownColor,
                              unselectedLabelColor: Colors.grey,
                              unselectedLabelStyle: TextStyles.font20GreyBold,
                              labelStyle: TextStyles.font20BrownBold,
                              indicatorColor: ColorsManager.brownColor,
                              dividerHeight: 1,
                              indicatorWeight: 4,
                              tabs: [
                                Tab(
                                  text: "تسجيل",
                                ),
                                Tab(
                                  text: "تسجيل جديد",
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.65, // لحجز مساحة مرنة
                              child: TabBarView(children: [
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.w),
                                    child: Form(
                                      key: formLoginKeys,
                                      child: Column(
                                        spacing: 15.h,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            spacing: 5,
                                            children: [
                                              Text(
                                                'رقم الجوال',
                                                style: TextStyles.font18BlackReg,
                                              ),
                                              IntlPhoneField(
                                                controller:
                                                    cubit.phoneLoginController,
                                                keyboardType: TextInputType.phone,
                                                initialCountryCode: 'SA',
                                                validator: (value){
                                                    if (value == null) {
                                                      return "phone must not be empty";
                                                    }
                                                    return null;
                                                },
                                                countries: [
                                                  Country(
                                                    name: "Saudi Arabia",
                                                    nameTranslations: {
                                                      "sk": "Saudská Arábia",
                                                      "se": "Saudi-Arábia",
                                                      "pl": "Arabia Saudyjska",
                                                      "no": "Saudi-Arabia",
                                                      "ja": "サウジアラビア",
                                                      "it": "Arabia Saudita",
                                                      "zh": "沙特阿拉伯",
                                                      "nl": "Saoedi-Arabië",
                                                      "de": "Saudi-Arabien",
                                                      "fr": "Arabie saoudite",
                                                      "es": "Arabia Saudí",
                                                      "en": "Saudi Arabia",
                                                      "pt_BR": "Arábia Saudita",
                                                      "sr-Cyrl":
                                                          "Саудијска Арабија",
                                                      "sr-Latn":
                                                          "Saudijska Arabija",
                                                      "zh_TW": "沙烏地阿拉",
                                                      "tr": "Suudi Arabistan",
                                                      "ro": "Arabia Saudită",
                                                      "ar": "السعودية",
                                                      "fa": "عربستان سعودی",
                                                      "yue": "沙地阿拉伯"
                                                    },
                                                    flag: "🇸🇦",
                                                    code: "SA",
                                                    dialCode: "966",
                                                    minLength: 9,
                                                    maxLength: 9,
                                                  )
                                                ],
                                                showDropdownIcon: false,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder()),
                                              ),
                                            ],
                                          ),
                                          // textFormLabelWidget(
                                          //     label: 'رقم الجوال',
                                          //     controller: phoneLoginController),
                                          textFormLabelWidget(
                                              label: 'كلمة المرور',
                                              controller:
                                                  cubit.passwordLoginController,
                                              obscure: true,
                                              validate: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "password must not be empty";
                                                }
                                                return null;
                                              }),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          defaultButton(
                                              event: () {
                                                if(formLoginKeys.currentState!.validate()){
                                                  cubit.loginUser();
                                                }
                                              },
                                              text:ConditionalBuilder(condition: state is! OnLoadingLoginState, builder: (context)=> Text("تسجيل",style: TextStyles.font18BrownRegular,), fallback:  (context)=>CircularProgressIndicator())),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "هل نسيت كلمة المرور ؟",
                                                style:
                                                    TextStyles.font16BrownRegular,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.w),
                                    child: Form(
                                      key: formKeys,
                                      child: Column(
                                        spacing: 10.h,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: textFormLabelWidget(
                                                  label: 'الاسم الاخير',
                                                  controller:
                                                      cubit.nameOneController,
                                                  obscure: false,
                                                  validate: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "name must not be empty";
                                                }
                                                return null;
                                              },
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                child: textFormLabelWidget(
                                                  label: 'الاسم الاول',
                                                  controller:
                                                      cubit.nameTowController,
                                                  obscure: false,
                                                  validate: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "name must not be empty";
                                                }
                                                return null;
                                              },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            spacing: 5,
                                            children: [
                                              Text(
                                                'رقم الجوال',
                                                style: TextStyles.font18BlackReg,
                                              ),
                                              IntlPhoneField(
                                                controller:
                                                    cubit.phoneRegisterController,
                                                keyboardType: TextInputType.phone,
                                                initialCountryCode: 'SA',
                                                validator: (value){
                                                  if (!value!.isValidNumber()) {
                                                    return "phone must not be empty";
                                                  }
                                                  return null;
                                                },
                                                countries: [
                                                  Country(
                                                    name: "Saudi Arabia",
                                                    nameTranslations: {
                                                      "sk": "Saudská Arábia",
                                                      "se": "Saudi-Arábia",
                                                      "pl": "Arabia Saudyjska",
                                                      "no": "Saudi-Arabia",
                                                      "ja": "サウジアラビア",
                                                      "it": "Arabia Saudita",
                                                      "zh": "沙特阿拉伯",
                                                      "nl": "Saoedi-Arabië",
                                                      "de": "Saudi-Arabien",
                                                      "fr": "Arabie saoudite",
                                                      "es": "Arabia Saudí",
                                                      "en": "Saudi Arabia",
                                                      "pt_BR": "Arábia Saudita",
                                                      "sr-Cyrl":
                                                          "Саудијска Арабија",
                                                      "sr-Latn":
                                                          "Saudijska Arabija",
                                                      "zh_TW": "沙烏地阿拉",
                                                      "tr": "Suudi Arabistan",
                                                      "ro": "Arabia Saudită",
                                                      "ar": "السعودية",
                                                      "fa": "عربستان سعودی",
                                                      "yue": "沙地阿拉伯"
                                                    },
                                                    flag: "🇸🇦",
                                                    code: "SA",
                                                    dialCode: "966",
                                                    minLength: 9,
                                                    maxLength: 9,
                                                  )
                                                ],
                                                showDropdownIcon: false,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder()),
                                              ),
                                            ],
                                          ),
                                          textFormLabelWidget(
                                            label: 'كلمة المرور',
                                            controller:
                                                cubit.passwordRegisterController,
                                            obscure: true,
                                            validate: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "password must not be empty";
                                                }
                                                return null;
                                              },
                                          ),
                                          textFormLabelWidget(
                                            label: 'تأكيد كلمة المرور',
                                            controller: cubit
                                                .rePasswordRegisterController,
                                            obscure: true,
                                            validate: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "password must not be empty";
                                                }
                                                return null;
                                              },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "الموافقه على الشروط والاحكام",
                                                style:
                                                    TextStyles.font14BrownRegular,
                                              ),
                                              Checkbox(
                                                value: check,
                                                onChanged: (value) {
                                                  setState(() {
                                                    check = !check;
                                                  });
                                                },
                                                activeColor:
                                                    ColorsManager.brownColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          defaultButton(
                                              event: () {
                                                if(formKeys.currentState!.validate()){
                                                  cubit.register();
                                                }
                                              },
                                              text:ConditionalBuilder(condition: state  is! OnLoadingRegisterState, builder: (context)=> Text("انشاء حساب",style: TextStyles.font18BrownRegular,), fallback:  (context)=>CircularProgressIndicator())),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
