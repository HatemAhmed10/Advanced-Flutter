import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../AddWord/AddWord.dart';

class AddSoundScreen extends StatefulWidget {
  const AddSoundScreen({Key? key}) : super(key: key);

  @override
  State<AddSoundScreen> createState() => _AddSoundScreenState();
}

class _AddSoundScreenState extends State<AddSoundScreen> {
  String fileType = 'All';
  FilePickerResult? result;
  PlatformFile? file;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
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
              title: Text("Get Aduio"),
            ),
            body: Container(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      pickFiles(fileType);
                      //cubit.AddSound("50","50",[file!.path.toString()]);
                    },
                    child: Text('Pick file'),
                  ),
                  if(file != null)...{
                    Text('File Path: ${file!.path}'),
                    Text('File Name: ${file!.name}')
                  }else...{
                    Text("Not Found"),
                  },
                  ElevatedButton(
                    onPressed: () async {
                      cubit.AddSound("50","50",file);
                    },
                    child: Text('Add'),
                  ),
                  // if (file != null) fileDetails(file!),
                  // if (file != null) ElevatedButton(onPressed: (){viewFile(file!);},child: Text('View Selected File'),)

                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget fileDetails(PlatformFile file){
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );

  }


  void pickFiles(String? filetype) async {
//        result = await FilePicker.platform.pickFiles(type: FileType.audio);
    result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    file = result!.files.first;
    setState(() {});
  }

  // open the picked file
  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

}
