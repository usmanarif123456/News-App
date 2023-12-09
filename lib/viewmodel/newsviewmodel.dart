import 'package:newsapp/Model/categoriesnewsmodel.dart';
import 'package:newsapp/Model/newschannelheadlinemodel.dart';
import 'package:newsapp/reprository/News-repository.dart';

class NewsViewModel{
final _rep=NewsRepository();

Future<NewsChannelHeadlinesModels>fetchNewsChannelHeadlinesModels(String channelName) async{

  final response = await _rep.fetchNewsChannelHeadlinesModels(channelName);
  return response;
}



Future<CategoriesNewsModels>fetchCategoriesNewsApi(String category) async{

  final response = await _rep.fetchCategoriesNewsApi(category);
  return response;
}

}