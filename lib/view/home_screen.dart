// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/api/api_services.dart';
import 'package:news_app/model/news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleModel> articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ApiServices newsy = ApiServices();
    await newsy.getData();
    articles = newsy.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          description: articles[index].description,
                          url: articles[index].url,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String? imageUrl, title, description, url;

  BlogTile({this.imageUrl, this.title, this.description, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(imageUrl!),
          ),
          Text(
            title!,
            style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            description!,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
