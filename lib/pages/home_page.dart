import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:news/pages/news_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Model? model;
  List<Articles>? articles;

  getDataFromNewsApi() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=69f835480f784e1ab8f8189ca2bfcf54"));
    model = Model.fromJson(jsonDecode(response.body));
    setState(() {
      articles = model!.articles;
      print(articles);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: RichText(
              text: TextSpan(
                text: 'NEWS',
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.indigoAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: const <TextSpan>[
                  TextSpan(
                    text: 'App',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )),
        body: articles == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: articles!.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        // ignore: unnecessary_null_comparison
                        if (articles![i].urlToImage == null)
                          Card(
                              elevation: 3,
                              color: Colors.red.shade50,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("Error to loading image"),
                              )))
                        else
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailPage(
                                          url: articles![i].url)));
                            },
                            child: Card(
                                elevation: 3,
                                child: Image.network(
                                    articles![i].urlToImage.toString())),
                          ),
                        SizedBox(height: 5),
                        Text(
                          articles![i].title.toString(),
                          style: TextStyle(
                              color: Colors.indigoAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Contents:  ',
                            style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              articles![i].content == null
                                  ? TextSpan(
                                      text: "Something went wrong!",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : TextSpan(
                                      text: articles![i].content,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Descriptions:  ',
                            style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              articles![i].description == null
                                  ? TextSpan(
                                      text: "Something went wrong!",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : TextSpan(
                                      text: articles![i].description,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }));
  }
}
