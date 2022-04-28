import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../AddSound/AddSound.dart';
import '../AddWord/AddWord.dart';

class GetSoundScreen extends StatelessWidget {
  //const GetSoundScreen({Key? key}) : super(key: key);
  int surahnumber ;
  int wordnumber ;
  GetSoundScreen(this.surahnumber,this.wordnumber);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetSounds(surahnumber, wordnumber),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is GetSoundLoadingHomeDataState)
          {
            print("FFFF");
          }else if(state is GetSoundSuccessHomeDataState){
            print("RRRRRRR");
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text("GetSoundScreen"),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(
                      context,
                      AddSoundScreen(),
                    );
                  },
                  icon: const Icon(
                      Icons.add
                  )),
            ],
            ),
            body: Center(
              child: Column(
                children: [
                  TextButton(
                      onPressed: ()async {
                        String x =cubit.FinalSound[0][0] ;
                        print(x);
                        final player = AudioPlayer();
                        //await player.play('https://res.cloudinary.com/hamers32/raw/upload/v1648302351/AudioUploads/s2..m4a');
                        await player.play(x);

                      },
                      child: Text("Play")),
                  //Text(cubit.FinalSound[0][0].toString()),
                ],
              ),

            ),
          );
        },
      ),
    );
  }
}
