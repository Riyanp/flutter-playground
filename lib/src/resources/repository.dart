import 'dart:async';

import 'package:dugoy_flutter_playground/src/models/photos_list_response.dart';
import 'package:dugoy_flutter_playground/src/resources/photo_api_provider.dart';

class Repository {
  final photosApiProvider = PhotoApiProvider();

  Future<PhotoListResponse> fetchCuratedPhotoList() => photosApiProvider.fetchCuratedPhotoList();
}