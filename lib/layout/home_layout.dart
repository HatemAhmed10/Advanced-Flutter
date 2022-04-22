import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:pharmacy_manager2/shared/cubit/cubit.dart';
import 'package:pharmacy_manager2/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..changex(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppChangeBottomNavBarState)
          {
            print(state.toString());
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          cubit.changey();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is AppChangeXState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => cubit.screens[cubit.currentIndex],
              //fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
