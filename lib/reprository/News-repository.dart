// ignore_for_file: unused_local_variable, file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:newsapp/Model/categoriesnewsmodel.dart';
import 'package:newsapp/Model/newschannelheadlinemodel.dart';
class NewsRepository{

Future<NewsChannelHeadlinesModels> fetchNewsChannelHeadlinesModels( String channelName) async{

  // ignore: unnecessary_brace_in_string_interps
  String url ='https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=5068eb057f5f499a94a713ea94ef1580';
  final response=await http.get(Uri.parse(url));
  if(kDebugMode){
    print(response.body);
  }

  if (response.statusCode==200){
final body=jsonDecode(response.body);
return NewsChannelHeadlinesModels.fromJson(body);

  }
throw Exception('ERROR');

}


Future<CategoriesNewsModels> fetchCategoriesNewsApi( String category) async{

  // ignore: unnecessary_brace_in_string_interps
  String url ='https://newsapi.org/v2/everything?q=${category}&apiKey=5068eb057f5f499a94a713ea94ef1580';
  final response=await http.get(Uri.parse(url));
  if(kDebugMode){
    print(response.body);
  }

  if (response.statusCode==200){
final body=jsonDecode(response.body);
return CategoriesNewsModels.fromJson(body);

  }
throw Exception('ERROR');

}
}