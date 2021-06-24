import 'package:flutter/material.dart';
import 'package:flutter_portal_berita/DetailNews.dart';
import 'package:flutter_portal_berita/api/Api.dart';
import 'package:flutter_portal_berita/api/ListBeritaResponse.dart';

import 'api/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Lauwba News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listNews = List<ListBeritaResponse>();
  var data = List<Data>();

  // mendeklarasikan function getNews
  void _getnews() async {
    // memanggil function getNews pada class Api dan mengambil response dari json
    // dengan aturan pengambilan json yg sudah ditetapkan pada class ListBeritaResponse
    Api.getNews().then((response) {
      setState(() {
        this.data = response.data;
      });
    });
  }

  // memanggil function dari class induk
  // initState untuk mengeksekusikan perintah2 pertama sebelum function build di eksekusikan
  @override
  void initState() {
    super.initState();

    // memanggil function getNews
    _getnews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext ctx, int index) {
            return GestureDetector(

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailNews(
                      data: data[index],
                    ),
                  ),
                );
              },

              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.0, style: BorderStyle.solid)
                      ),
                      alignment: Alignment.center,
                      child: Image.network(
                        data[index].foto_news,
                        fit: BoxFit.cover,
                        width: 120.0,
                        height: 65.0,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(

                            child: CircularProgressIndicator(

                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,

                            ),

                          );

                        },
                      ),
                    ),


                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  data[index].jdl_news,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data[index].post_on,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
