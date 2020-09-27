import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
 

  Future<List> uploadFileAndGetURL(
      {List<String> filepathList, List<io.File> files}) async {
    List<String> resultList = [];

    for (int i = 0; i < files.length; i++) {
      String result;
      String filepath = filepathList[i];
      io.File file = files[i];
      StorageReference _reference =
          FirebaseStorage.instance.ref().child(filepath);
      StorageTaskSnapshot taskSnapshot =
          await _reference.putFile(file).onComplete;
      if (taskSnapshot != null) {
        print("$i time \n");

        await _reference
            .getDownloadURL()
            .then((uploadedFileURL) => result = uploadedFileURL);
        if (result != null) {
          // print('File URL: - $result');
          resultList.add(result);
        } else {
          return [];
        }
      } else {
        return [];
      }
    }

    print('File URL List from storage: - $resultList');
    return resultList;
  }
}
