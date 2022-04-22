import 'package:pharmacy_manager2/shared/components/components.dart';
import 'package:pharmacy_manager2/shared/cubit/cubit.dart';
import 'package:pharmacy_manager2/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// هنا بقا مش بيسمع لل home_layout بيسمع لنفسه والي بيحصل عنده وبس
class NewTasksScreen extends StatelessWidget
{
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
            body: Center(
              child: Column(
                children: [
                  Text("x = ${cubit.x.toString()}"),
                  SizedBox(height: 50,),
                  Text("y = ${cubit.y.toString()}"),
                  SizedBox(height: 50,),
                  RaisedButton(
                    onPressed: (){
                      cubit.changeZ();
                    },
                    child: Text("Change Z"),),
                  Text("z = ${cubit.z.toString()}"),
                  SizedBox(height: 50,),
                  Text(
                    "data",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RaisedButton(
                    onPressed: (){
                      showToast(text: "sasadas dsadasdas das as dsa", state: ToastStates.SUCCESS);
                    },
                  child: Text(
                    "Add",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}