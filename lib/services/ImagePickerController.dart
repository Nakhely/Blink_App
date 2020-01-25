import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future <File> getImageFromGallery () async {
  return await ImagePicker.pickImage(source: ImageSource.gallery);
}

Future <File> getImageFromCamera () async {
  return await ImagePicker.pickImage(source: ImageSource.camera);
}