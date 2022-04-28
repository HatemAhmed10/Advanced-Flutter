import 'package:audioplayers/audioplayers.dart';
import 'package:ezz1/shared/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/SoundModel.dart';
import '../../models/user/WordModel.dart';
import '../../network/remote/dio_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<String> AddWordList = [] ;
  void ChangeWordList(String word){
    AddWordList.add(word);
    emit(ChangeWordListState());
  }

  DioClient _client = DioClient();
  List FinalSound =[] ;
  List FinalWord = [] ;
  Word? wordModel ;
  List WordList = [];
  void GetWords(int surahnumber) {
    WordList = [] ;
    FinalWord =[] ;
    emit(GetWordLoadingHomeDataState());
    _client.getWord(surahnumber: surahnumber).then((value){
      WordList.add(value!.toJson()['word']);
      FinalWord.add(WordList[0][0]['words']);
      emit(GetWordSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWordErrorHomeDataState());
    });
  }

  List SoundList = [];
  void GetSounds(int surahnumber ,int wordnumber) {
    SoundList = [] ;
    FinalSound =[] ;
    emit(GetSoundLoadingHomeDataState());
    _client.getSound(surahnumber:surahnumber, wordnumber: wordnumber).then((value){
      SoundList.add(value!.toJson()['sound']);
      FinalSound.add(SoundList[0][0]['sounds']);
      emit(GetSoundSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSoundErrorHomeDataState());
    });
  }


  // ignore: non_constant_identifier_names
  void AddWord(@required String surahnumber ,@required List<String> word) {
    emit(AddWordLoadingHomeDataState());
    Word userInfo = Word(
        surahnumber: surahnumber,
        words: word,
    );
    _client.addwords(userInfo).then((value){
      //print(value!.toJson());
      emit(AddWordSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AddWordErrorHomeDataState());
    });
  }




  // ignore: non_constant_identifier_names
  void AddSound(@required String surahnumber,@required String wordnumber ,@required PlatformFile? file) {
    emit(AddWordLoadingHomeDataState());
    Sound userInfo = Sound(
      surahnumber: surahnumber,
      wordnumber: wordnumber,
      //sounds: sounds
    );
    _client.addsound(userInfo,file).then((value){
      //print(value!.toJson());
      emit(AddWordSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AddWordErrorHomeDataState());
    });
  }







  AudioPlayer _audioPlayer = AudioPlayer();
  void PlaySound ()async {
    int result = await _audioPlayer.play(
        'http://res.cloudinary.com/hamers32/raw/upload/v1648302350/AudioUploads/s1..m4a');
  }

  String fileType = 'All';
  FilePickerResult? result;
  PlatformFile? file;



}
