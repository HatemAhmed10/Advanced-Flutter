import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmacy_manager2/shared/styles/themes.dart';
import 'layout/product/cubit/cubit.dart';
import 'layout/product/cubit/states.dart';
import 'layout/product/product_layout.dart';





void main() async{
  //Bloc.observer = MyBlocObserver();
  //runApp(MyApp());

  // await Firebase.initializeApp();
  // Bloc.observer = MyBlocObserver();
  // DioHelper.init();
  //await CacheHelper.init();
  BlocOverrides.runZoned(
          () {
            runApp(MyApp());
      },
      //blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: ThemeMode.light,
      home: ProductLayout(),
    );
  }
}

//
//
// class MyApp extends StatelessWidget
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return BlocProvider(
//       create: (BuildContext context) => ProductCubit(),
//       child: BlocConsumer<ProductCubit, ProductStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           ProductCubit cubit = ProductCubit.get(context);
//
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: lightTheme,
//             // darkTheme: darkTheme,
//             // themeMode: ThemeMode.light,
//             home: ProductLayout(),
//           );
//         },
//       ),
//     );
//   }
// }