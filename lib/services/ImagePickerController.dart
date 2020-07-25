import 'dart:io';

import 'package:image_picker/image_picker.dart';

final _picker = ImagePicker();

Future <PickedFile> getImageFromGallery () async {
  return await _picker.getImage(source: ImageSource.gallery);
}

Future <PickedFile> getImageFromCamera () async {
  return await _picker.getImage(source: ImageSource.camera);
}