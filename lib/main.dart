import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_manager2/shared/bloc_observer.dart';
import 'package:pharmacy_manager2/shared/cubit/cubit.dart';
import 'package:pharmacy_manager2/shared/cubit/states.dart';
import 'package:pharmacy_manager2/shared/styles/themes.dart';
import 'modules/splash/splash_view.dart';





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
      blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
             theme: lightTheme,
            // darkTheme: darkTheme,
            // themeMode: ThemeMode.light,
            home: SplashView(),
          );
        },
      ),
    );
  }
}