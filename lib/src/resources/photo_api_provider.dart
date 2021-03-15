import 'dart:async';
import 'package:dugoy_flutter_playground/src/models/photos_list_response.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class PhotoApiProvider {
  Client client = Client();
  final _apiKey = '563492ad6f91700001000001ab5ebb966a95494ab7c23c2fb6c51256';

  Future<PhotoListResponse> fetchCuratedPhotoList() async {
    print("getting curated photos");
    Map<String, String> requestHeaders = {'Authorization': _apiKey};
    final response = await client.get(
        "https://api.pexels.com/v1/curated?per_page=20",
        headers: requestHeaders);
    print(response.body.toString());
    if (response != null) {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return PhotoListResponse.fromJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        return PhotoListResponse.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception('Failed to load post');
    }
  }
}
