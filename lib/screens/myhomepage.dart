import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/api_service.dart';

import '../widgets/news_card.dart';

class MyHomePage extends StatelessWidget {
  final apiservice = ApiService();
  NewsModel? _response;
  List<Article> article_list = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: apiservice.getarticles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                itemCount: articles?.length,
                itemBuilder: (context, index) =>
                    customListTile(articles![index], context),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  signout();
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  void getdata() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(child: CircularProgressIndicator());
    //     });
    var _response = await apiservice.getarticles();
    print(_response.first.description);
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
