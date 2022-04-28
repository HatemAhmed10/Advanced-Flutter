import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../AddWord/AddWord.dart';
import '../GetSound/GetSound.dart';

class GetDataScreen extends StatelessWidget {
  const GetDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _surahnumber = TextEditingController();
    TextEditingController _wordnumber = TextEditingController();
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
              title: const Text("GetDataScreen"),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(
                        context,
                        AddWordScreen(),
                      );
                    },
                    icon: const Icon(
                        Icons.add
                    )),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: 200,
                              height: 50,
                              child: TextFormField(
                                controller: _surahnumber,
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
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: RaisedButton(
                                onPressed: (){
                                  cubit.GetWords(int.parse(_surahnumber.text));
                                  //cubit.GetSounds(int.parse(_surahnumber.text),int.parse(_wordnumber.text));
                                },
                                child: const Text("Get")),
                          ),
                          ],
                        ),
                      ),

                      ConditionalBuilder(
                          condition: cubit.FinalWord.isNotEmpty,
                          builder: (context) => Container(
                            child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Column(
                                    children:  [
                                        TextButton(
                                          onPressed: (){
                                            // cubit.GetSounds(int.parse(_surahnumber.text), index);
                                            // if(state is GetSoundSuccessHomeDataState){
                                            //   print(cubit.FinalSound.toString());
                                            // }
                                            navigateTo(
                                              context,
                                              GetSoundScreen(int.parse(_surahnumber.text),index),
                                            );

                                          },
                                          child: Text(cubit.FinalWord[0][index].toString(),
                                            style: const TextStyle(
                                              color: Colors.pink,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) => const SizedBox(
                                  width: 10.0,
                                ),
                                itemCount: cubit.FinalWord[0].length),
                          ),
                          fallback:(context) => Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
