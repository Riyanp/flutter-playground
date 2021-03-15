import 'package:dugoy_flutter_playground/src/models/photos_list_response.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PhotosBloc {
  final _repository = Repository();
  final _photosFetcher = PublishSubject<PhotoListResponse>();

  Observable<PhotoListResponse> get allPhotos => _photosFetcher.stream;

  fetchCuratedPhotoList() async {
    try {
      PhotoListResponse response = await _repository.fetchCuratedPhotoList();
      _photosFetcher.sink.add(response);
    } catch (e) {
      _photosFetcher.sink.addError(e);
    }
  }

  dispose() {
    _photosFetcher.close();
  }
}

final photoBloc = PhotosBloc();