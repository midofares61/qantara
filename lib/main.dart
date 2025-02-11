import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qantara/qantara_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/cubit/bloc_observer.dart';
import 'core/networking/local/cache_helper.dart';
import 'core/routing/app_router.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp( QantaraApp(
    appRouter: AppRouter(),
  ));
}

