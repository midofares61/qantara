import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qantara/core/di/cubit/states.dart';
import 'package:qantara/core/di/models/order_model.dart';
import 'package:qantara/core/di/models/price_model.dart';
import 'package:qantara/core/networking/local/cache_helper.dart';
import 'package:qantara/features/home/tab/home_tab.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../features/home/tab/profile_tab.dart';
import '../../../features/home/tab/talabat_tab.dart';
import '../models/user_model.dart';

class CubitApp extends Cubit<StateApp> {
  CubitApp() : super(InitialState());
  static CubitApp get(context) => BlocProvider.of(context);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int currentIndex=0;
  void changeIndex(int index){
    currentIndex=index;
    emit(ChangeIndexState());
  }
List<Widget> screens=[
  HomeTabScreen(),
  TalabatTab(),
  ProfileTab(),
];
  UserModel? user;
  void getUser({
    required String phone
})async{
    emit(OnLoadingGetUserState());
    await firestore.collection('users').doc(phone).get().then((value){
      user=UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: "phone", value: user!.phone);
      print(user!.phone);
       getOrder();
      emit(SuccessGetUserState());
    }).catchError((e){
      emit(ErrorGetUserState());
    });
  }

  late Database db;
  List<Map> cars = [];

  Future<void> createDatabaseAndTable() async {
    db = await openDatabase(
      join(await getDatabasesPath(), "Cars.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Cars (
            id INTEGER PRIMARY KEY,
            brand TEXT,
            category TEXT,
            model TEXT,
            number TEXT,
            name TEXT
          )
        ''');
        print("Database 'Cars.db' and table 'Cars' created");
      },
      onOpen: (db) {
        print("Database 'Cars.db' opened");
      },
    );

    await getUsers();
    emit(CreateCarsDbState());
  }

  Future<List<Map>> getUsers() async {
    cars = await db.query("Cars");
    emit(GetCarsDbState());
    return cars;
  }

  insertData({
    required String brand,
    required String category,
    required String model,
    required String number,
    required String name,
  })async{
    db.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Cars(brand, category, model, number, name) VALUES("$brand", "$category", "$model", "$number", "$name")')
          .then((value){
        print("insert data id = $value");
        emit(InsertCarsDbState());
        getCars().then((value){
          cars=value;
          emit(GetCarsDbState());
        });
      });
    });
  }

  Future<List<Map>> getCars()async{
    return await db.rawQuery("select * from Cars");
  }

  deleteUser(int id){
    db.rawDelete("delete from Cars where id = ?",[id]).then((value){
      emit(DeleteCarsDbState());
      getCars().then((value){
        cars=value;
        emit(GetCarsDbState());
      });
    });
  }

  File? categoryImage;
  Future picCategoryImageFromGallery() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      categoryImage = File(pickedImage.path);
      emit(ImagePickedSuccessState());
    } else {
      print("no Image Selected");
      emit(ImagePickedErrorState());
    }
  }

  void addOrder({
    required String name,
    required String image,
    required String brand,
    required String color,
    required String notes,
})async{
    emit(OnLoadingAddOrderState());
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("orders");
    String newId = collectionRef.doc().id;
    await collectionRef.doc(newId).set({
      'name': name,
      'image': image,
      'brand': brand,
      'color': color,
      'phone': user!.phone,
      'nameUser': user!.firstName,
      'id': newId,
      'status': "جاري التسعير",
      'notes': notes,
      'dateTime': DateTime.now().toString(),
      'number': 0,
    }).then((value){
      emit(SuccessAddOrderState());
    }).catchError((e){
      emit(ErrorAddOrderState());
    });
  }
List<OrderModel>? orders;
  Future<void> getOrder()async{
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("orders");
    await collectionRef.where('phone', isEqualTo: user!.phone).snapshots()
        .listen((event) {
      orders=[];
      for (var element in event.docs) {
        final data = element.data() as Map<String, dynamic>;
        orders!.add(OrderModel.fromJson(data));
      }
      emit(SuccessGetOrderState());
    });

  }

  List<PriceModel>? pricing;
  Future<void> getPrice(String id)async{
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("pricing");
    await collectionRef.where("idOrder",isEqualTo: id).snapshots()
        .listen((event) {
      pricing=[];
      for (var element in event.docs) {
        final data = element.data() as Map<String, dynamic>;
        pricing!.add(PriceModel.fromJson(data));
      }
      emit(SuccessGetPricingState());
    });

  }
}
