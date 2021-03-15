import 'package:dugoy_flutter_playground/src/blocs/photos_bloc.dart';
import 'package:dugoy_flutter_playground/src/models/photos_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> with SingleTickerProviderStateMixin {
  int gridSize;

  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    gridSize = 2;
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    photoBloc.fetchCuratedPhotoList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo list example'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.grid_view,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _controller.reset();
                  _controller.forward().orCancel;
                  gridSize = 2;
                });
              }),
          IconButton(
              icon: Icon(
                Icons.list_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _controller.reset();
                  _controller.forward().orCancel;
                  gridSize = 1;
                });
              })
        ],
      ),
      body: StreamBuilder(
        stream: photoBloc.allPhotos,
        builder: (context, AsyncSnapshot<PhotoListResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null) {
              _showSnackBar(context, snapshot.data.error);
            } else {
              _controller.forward().orCancel;
              if (gridSize == 1) {
                return SizeTransition(
                    sizeFactor: _animation, child: buildList(snapshot));
              } else {
                return SizeTransition(
                    sizeFactor: _animation, child: buildGridList(snapshot));
              }
            }
          } else if (snapshot.hasError) {
            _showSnackBar(context, snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<PhotoListResponse> snapshot) {
    List<Photos> photos = snapshot.data.photos;

    return ListView.builder(
        itemCount: snapshot.data.photos.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkResponse(
              enableFeedback: true,
              onTap: () {
                _showSnackBar(
                    context, snapshot.data.photos[index].photographer);
              },
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    snapshot.data.photos[index].src.medium,
                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(photos[index].photographer, style: _bigTextStyle()),
                      Text(
                        photos[index].photographerUrl,
                        style: _smallTextStyle(),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  Widget buildGridList(AsyncSnapshot<PhotoListResponse> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.photos.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: InkResponse(
                child: Image.network(snapshot.data.photos[index].src.medium,
                    fit: BoxFit.cover),
                enableFeedback: true,
                onTap: () {
                  _showSnackBar(
                      context, snapshot.data.photos[index].photographer);
                },
              ),
            ),
          );
        });
  }

  /// Function to show snackbar from inside stream builder.
  Widget _showSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(message),
        ));
    });
    return Container();
  }

  TextStyle _bigTextStyle() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  }

  TextStyle _smallTextStyle() {
    return TextStyle(fontWeight: FontWeight.normal, fontSize: 12);
  }
}
