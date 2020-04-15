import 'package:flutter/material.dart';
import 'package:news/src/screens/news_detail.dart';
import 'package:news/src/screens/news_list.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "News",
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings){
            return MaterialPageRoute(
              builder: (context){
                return NewsList();
              }
            );
          },
        ),
      ),
    );
  }
  Route routes(RouteSettings settings){
    if(settings.name == '/'){

      return MaterialPageRoute(
          builder: (context){
            final bloc = StoriesProvider.of(context);
            bloc.fetchTopIds();
            return NewsList();
          }
      );
    }else{

      return MaterialPageRoute(
          builder: (context){
            final commentsBloc  = CommentsProvider.of(context);
            final itemId = int.parse(settings.name.replaceFirst("/", ''));
            return NewsDetail (itemId:itemId);
          }
      );
    }

  }
}