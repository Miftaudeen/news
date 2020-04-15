import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){
  test("FetchTopIds returns list of ids", () async{
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request)async{
      return Response(json.encode([12,67,5,34,45,4,25]), 200);
    });


    final ids = await newsApi.fetchTopIds();

    expect(ids, [12,67,5,34,45,4,25]);
  });

  test("FetchItem returns a Item model", () async{
final newsApi = NewsApiProvider();
newsApi.client = MockClient((request)async{
  final jsonMap = {"id":123};
return Response(json.encode(jsonMap), 200);
});


final item = await newsApi.fetchItem(999);

expect(item.id, 123);
});
}