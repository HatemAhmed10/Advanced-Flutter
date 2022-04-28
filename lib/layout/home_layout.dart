import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/GetData/GetData.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppChangeBottomNavBarState)
          {
            print(state.toString());
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            body: ConditionalBuilder(
              condition: state is AppInitialState,
              builder: (context) => GetDataScreen(),
              fallback: (context) => GetDataScreen(),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.pink,
              onPressed: (){
                //cubit.AddSound("2", ["2","2"]);
                // navigateTo(
                //   context,
                //   PostDataScreen(),
                // );
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
