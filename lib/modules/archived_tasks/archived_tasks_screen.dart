import 'package:pharmacy_manager2/shared/components/components.dart';
import 'package:pharmacy_manager2/shared/cubit/cubit.dart';
import 'package:pharmacy_manager2/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// هنا ده بيسمع علي اي حاجه في ال home_layout وبيتغير علي طول
class ArchivedTasksScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        AppCubit cubit = AppCubit.get(context);
        cubit.changeZ();

        return Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(cubit.x.toString()),
              SizedBox(height: 50,),
              Text(cubit.y.toString()),
              SizedBox(height: 50,),
              Text(cubit.z.toString()),
              SizedBox(height: 50,),
              myDivider(),
            ],
          ),
        ),
        );
      },
    );
  }
}