import 'dart:convert';

import '../DetailResponse.dart';
import 'ListBeritaResponse.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://lauwba.com/webservices/";

class Api {
  static Future<ListBeritaResponse>getNews() async {

    var url = baseUrl + "get_latest_news";

    // memanggil api dengan base_url yang sudah tertera di variabel url
    final response = await http.get(url);

    // cek dulu apakah status code pada api adalah 200
    if (response.statusCode == 200) {
      // jika ya, melakukan convert json ke array dart
      // setelah convert, selanjutnya mengembalikan nilai hasil convert
      // print(ListBeritaResponse.fromJson(jsonDecode(response.body)));
      return ListBeritaResponse.fromJsonMap(jsonDecode(response.body));
    } else {
      // jika tidak, pesan error akan ditampilkan dalam console
      throw "Failed to get news";
    }

  }

  static Future<DetailResponse> getDetailNews(String idNews) async{
    var url = baseUrl + "get_detail_news/$idNews";
    final response = await http.get(url);
    if(response.statusCode == 200){
      return DetailResponse.fromJsonMap(jsonDecode(response.body));
    }else{
      throw Exception("No data to load");
    }
  }


}