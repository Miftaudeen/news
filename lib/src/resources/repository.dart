import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'package:news/src/models/item_model.dart';


class Repository{
  List<Source> sources = <Source>[newsDbProvider, NewsApiProvider()];
  List<Cache> caches = <Cache>[newsDbProvider];
  Future<List<int>> fetchTopIds() async {
    // TODO iterate over sources and call fetchTopIds
    return await sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int i) async {
    ItemModel itemModel;
    var source;
    for (source in sources){
      itemModel = await source.fetchItem(i);
      if(itemModel != null){
        break;
      }
    }
    for(var cache in caches){
      if(cache != source) {
        cache.addItem(itemModel);
      }
    }
    return itemModel;
  }

  clearCache() async{
    for(var cache in caches){
      await cache.clear();
    }
  }
}

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache{
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}