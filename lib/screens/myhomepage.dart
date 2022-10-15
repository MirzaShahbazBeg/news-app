import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/api_service.dart';
import 'package:provider/provider.dart';

import '../services/signin_provider.dart';
import '../widgets/news_card.dart';

class MyHomePage extends StatelessWidget {
  final apiservice = ApiService();
  TextEditingController searchController = TextEditingController();
  NewsModel? _response;
  List<Article> article_list = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search in feed ',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              // onChanged: (text) {
              //   text = text.toLowerCase();
              //   apiservice.getarticles(text);
              // },
            ),
            FutureBuilder(
              future: apiservice.getnews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Article>> snapshot) {
                if (snapshot.hasData) {
                  List<Article>? articles = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: articles?.length,
                      itemBuilder: (context, index) =>
                          customListTile(articles![index], context),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                  signout();
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  // void getdata() async {
  //   // showDialog(
  //   //     context: context,
  //   //     builder: (context) {
  //   //       return Center(child: CircularProgressIndicator());
  //   //     });
  //   var _response = await apiservice.getarticles(searchController.text);
  //   print(_response.first.description);
  // }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
