import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout.dart';
import '../../models/user/WordModel.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class AddWordScreen extends StatelessWidget {
  const AddWordScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController _surahnumber2 = TextEditingController();
    TextEditingController _word = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInitialState)
          {
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text("PostDataScreen"),
            ),
            body: Container(
                alignment: AlignmentDirectional.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 100,),
                      Container(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                          controller: _surahnumber2,
                          style: TextStyle(color: Colors.amber),
                          decoration: InputDecoration(
                            icon: new Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: 'رقم السوره',
                            labelStyle: TextStyle(color: Colors.amber,fontSize: 15),
                            hintText: 'رقم السوره',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                          controller: _word,
                          style: TextStyle(color: Colors.amber),
                          decoration: InputDecoration(
                            icon: new Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: 'الكلمه',
                            labelStyle: TextStyle(color: Colors.amber,fontSize: 15),
                            hintText: 'الكلمه',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          width: 200,
                          height: 50,
                          child: IconButton(
                            onPressed: (){
                              cubit.ChangeWordList(_word.text);
                              cubit.AddWordList.toString();
                              _word.clear();
                            },
                            icon: Icon(Icons.add),
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: 200,
                        height: 50,

                        child: Text(cubit.AddWordList.toString()),
                      ),
                      SizedBox(height: 30,),
                      Container(
                          width: 200,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.pink,
                            onPressed: (){
                              print(cubit.AddWordList.toString());

                              cubit.AddWord(_surahnumber2.text,cubit.AddWordList);
                              cubit.AddWordList.clear();
                            },
                            child: Text("Add"),
                          )
                      ),
                    ],
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
