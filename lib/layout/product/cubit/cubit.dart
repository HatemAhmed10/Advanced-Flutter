import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_manager2/layout/product/cubit/states.dart';
import 'package:pharmacy_manager2/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../../modules/product_app/Home_screen.dart';
import '../../../modules/product_app/order_screen.dart';
import '../../../shared/components/components.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    OrderScreen(),
  ];

  List<String> titles = [
    'Home Tasks',
    'Order Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ProductChangeBottomNavBarState());
  }
//-----------------------------------------------------------

   // 1- Add Order

  late Database database ;
  void createDatabase() {
    openDatabase(
      'manage.db',
      version: 3,
      onCreate: (database, version)  {
        print('database created');
        database.execute(
            'CREATE TABLE Product (_id INTEGER PRIMARY KEY,'
                ' P_type TEXT,'
                ' P_name TEXT,'
                ' P_number TEXT ,'
                ' P_salary TEXT )')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
         database.execute(
            'CREATE TABLE Product2 (_id2 INTEGER PRIMARY KEY,'
                ' Number_Order TEXT,'
                ' O_name TEXT,'
                ' O_number TEXT ,'
                ' O_date TEXT ,'
                ' F_cost TEXT )')
            .then((value) {
          print('table2 created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
       onOpen: (database) {
         GetPtypeData(database);
        // GetAllData(database);
        //GetOneData(database: database, type: "A");
        //GetPtypeData(database);
        print('database opened');
      },
    ).then((value) {
      database = value ;
      emit(AppCreateDatabaseState());
    });
  }


  AddData({@required String? type, @required String? name, @required String? number,@required String? salary,}) async{
     await database.rawQuery('SELECT * FROM Product WHERE P_type =? AND P_name =?',[type, name]).then((value)  async {
      if(value.isEmpty){
        await database.transaction((txn) {
          return txn.rawInsert(
            'INSERT INTO Product(P_type, P_name, P_number, P_salary) VALUES("$type", "$name", "$number", "$salary")',
          ).then((value) {
            showToast(text: " تم الاضافه$value ", state: ToastStates.SUCCESS);
            emit(AppInsertDatabaseState());
            GetPtypeData(database);
          }).catchError((error) {
            showToast(text: "error", state: ToastStates.ERROR);
          });
        });

      }else{
        await database.rawUpdate(
          'UPDATE Product SET P_number = ? , P_salary = ?  WHERE P_type =? AND P_name =?',
          ['$number','$salary', type, name],
        ).then((value)
        {
          showToast(text: " تم ألتحديث$value ", state: ToastStates.SUCCESS);
          emit(AppInsertDatabaseState());
          GetPtypeData(database);
        });
      }
    });
  }


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
//---------------------------------------------------------
 // 2- GetOrder
  List<Map> TypeProduct = [] ;
  List<Map> AllTypeData = [];

  void GetPtypeData(database) {
    TypeProduct = [];
     database.rawQuery('SELECT DISTINCT P_type FROM Product').then((value)  {
      value.forEach((element)
      {
        TypeProduct.add(element);
      });
      print(value.toString());
      if(TypeProduct.isEmpty){
        print(TypeProduct.length.toString());
      }else{
        GetOneData(database: database,type: TypeProduct[0]['P_type'].toString());
      }
      emit(AppFetchPtypeDatabaseState());
    });
  }



  void GetOneData({@required database,@required String? type}){
    AllTypeData = [];
    database.rawQuery('SELECT * FROM Product WHERE P_type =?',[type]).then((value) {
      value.forEach((element)
      {
        AllTypeData.add(element);
      });
      //constValue();
      emit(AppFetchOneDatabaseState());
      //print(AllTypeData.toString());
    });
  }
// -------------------------------------------------------
// 3-Take Order
  Map OrderList ={};
  void AddArray(int index){
    OrderList[AllTypeData[index]['P_type'].toString()+AllTypeData[index]['P_name'].toString()]=[AllTypeData[index]['P_type'].toString(),
      AllTypeData[index]['P_name'].toString(),
      AllTypeData[index]['P_number'].toString(),
      AllTypeData[index]['P_salary'].toString()];
    emit(AddArrayState());
  }



  Map FNumber ={};
  // String FNumber ='' ;
  void changeFNumber(String data,int index){
    FNumber[index] =data ;
    emit(ChangeFNumberState());
  }



  AddOrder({@required String? NumberOrder,@required String? name, @required String? number,@required String? cost,@required String? Finalcost,}) async{
    await database!.transaction((txn) {
      txn.rawInsert(
        'INSERT INTO Product2(Number_Order, O_name, O_number, O_cost, F_cost) VALUES("$NumberOrder", "$name", "$number", "$cost", "$Finalcost")',
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertOrderDatabaseState());
        //GetAllData(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
      return null as Future;
    });
  }



}


