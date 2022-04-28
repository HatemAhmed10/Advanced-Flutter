import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

import '../../models/user/SoundModel.dart';
import '../../models/user/WordModel.dart';
import 'logging.dart';




class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://quran50.herokuapp.com',
      // connectTimeout: 5000,
      // receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());


  Future<WordModel?> getWord({required int surahnumber}) async {
    WordModel? wordModel;
    try {
      Response userData = await _dio.get('/admin/get_Words/$surahnumber');
      wordModel = WordModel.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return wordModel;
  }

  Future<SoundModel?> getSound({required int surahnumber,required int wordnumber}) async {
    SoundModel? soundModel;
    try {
      Response userData = await _dio.get('/user/get_sounds/$surahnumber/$wordnumber');
      soundModel = SoundModel.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return soundModel;
  }







  Future<Word?> addwords (@required Word userInfo) async {
    Word? retrievedUser;

    try {
      Response response = await _dio.post(
        '/admin/add_word/',
        data: userInfo,
      );
      print('User created: ${response.data}');

      //retrievedUser = Post.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }



  Future<Sound?> addsound (@required Sound userInfo,@required PlatformFile? file) async {
    Sound? retrievedUser;
    FormData data = FormData.fromMap({
      // "surahnumber":userInfo.surahnumber,
      // "wordnumber":userInfo.wordnumber,
      //"files":userInfo.sounds
      "surahnumber":"1000",
      "wordnumber":"1",
      "files": [ await MultipartFile.fromFile(
          file!.path.toString(),
          filename: basename(file!.path.toString())
        //show only filename from path
      )]

    });

    try {
      Response response = await _dio.post(
        '/user/add_sound/',
        data: data,
      );
      print('User created: ${response.data}');

      //retrievedUser = Post.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }



}











