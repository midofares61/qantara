import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/local/cache_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
 late String verification;
  final TextEditingController phoneLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController phoneRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController = TextEditingController();
  final TextEditingController rePasswordRegisterController = TextEditingController();
  final TextEditingController nameOneController = TextEditingController();
  final TextEditingController nameTowController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> register()async{
  emit(OnLoadingRegisterState());
  await firestore.collection('users').doc(phoneRegisterController.text).set({
    'firstName': nameOneController.text,
    'lastname': nameTowController.text,
    'phone': phoneRegisterController.text,
    'password': passwordRegisterController.text,
  }).then((value){
    CacheHelper.saveData(key: "phone", value: phoneRegisterController.text);
    emit(RegisterSuccessState());
  }).catchError((e){
    emit(RegisterSuccessState());
  });

}

  Future<bool> loginUser() async {
    emit(OnLoadingLoginState());
    DocumentSnapshot userDoc =
    await firestore.collection('users').doc(phoneLoginController.text).get();

    if (userDoc.exists) {
      String storedPassword = userDoc['password'];
      if (passwordLoginController.text == storedPassword) {
        CacheHelper.saveData(key: "phone", value: userDoc['phone']);
        emit(LoginSuccessState());
        return true;
      }
    }
    emit(LoginSuccessState());
    return false;
  }




}
