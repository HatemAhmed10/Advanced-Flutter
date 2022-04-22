import 'package:flutter/material.dart';
import 'package:pharmacy_manager2/shared/components/components.dart';
import 'package:pharmacy_manager2/shared/cubit/cubit.dart';
import 'package:pharmacy_manager2/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// هنا هو بيسمع لل home_layout بس مش بيغير هو في حاجه
class DoneTasksScreen extends StatelessWidget {
  TextEditingController userInput = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(cubit.x.toString()),
                    SizedBox(height: 50,),
                    Text(cubit.y.toString()),
                    SizedBox(height: 50,),
                    RaisedButton(
                      onPressed: (){
                        cubit.changeZ();
                      },
                      child: Text("Change Z"),),
                    Text("z = ${cubit.z.toString()}"),
                    SizedBox(height: 50,),
                    defaultButton(
                        function: (){
                          showToast(text: "sasadas dsadasdas das as dsa", state: ToastStates.SUCCESS);
                        },
                        text: "defaultButton"),

                    SizedBox(height: 20,),
                    defaultTextButton(
                        function: (){
                          if (formKey.currentState!.validate()) {}
                          },
                        text: "defaultTextButton"),

                    SizedBox(height: 20,),
                    defaultFormField(
                        controller: userInput,
                        type: TextInputType.number,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        label: 'User Name',
                        prefix: Icons.person,),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
