// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pharmacy_manager2/shared/cubit/states.dart';
// import '../../modules/archived_tasks/archived_tasks_screen.dart';
// import '../../modules/done_tasks/done_tasks_screen.dart';
// import '../../modules/new_tasks/new_tasks_screen.dart';
//
// class AppCubit extends Cubit<AppStates> {
//   AppCubit() : super(AppInitialState());
//
//   static AppCubit get(context) => BlocProvider.of(context);
//
//   int currentIndex = 0;
//
//   List<Widget> screens = [
//     NewTasksScreen(),
//     DoneTasksScreen(),
//     ArchivedTasksScreen(),
//   ];
//
//   List<String> titles = [
//     'New Tasks',
//     'Done Tasks',
//     'Archived Tasks',
//   ];
//
//   void changeIndex(int index) {
//     currentIndex = index;
//     emit(AppChangeBottomNavBarState());
//   }
//
//   int x=0 ;
//   int y =0 ;
//   int z =0 ;
//
//   void changex(){
//     x++ ;
//     emit(AppChangeXState());
//   }
//
//   void changey(){
//     y++ ;
//     emit(AppChangeYState());
//   }
//
//   void changeZ(){
//     z++ ;
//     emit(AppChangeZState());
//   }
//
//   int d = 6 ;
//   void changed(){
//     d = 100 ;
//     print("sasa");
//     emit(AppChangeDState());
//   }
// }
