import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inu_stream_ios/pages/info_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _textEditingController;
  String animeName = '';

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff16151A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 140.0,
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.all(14.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  animeName = value.toLowerCase().replaceAll(' ', '-');
                });
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<http.Response>(
        future: http.get(
          Uri.parse(
              'https://consumet-api.herokuapp.com/meta/anilist/${animeName}?provider=zoro'),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var json = jsonDecode(snapshot.data!.body)['results'];
            return Container(
              height: 600.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                  itemCount: json.length,
                  itemBuilder: ((context, index) {
                    if (json[index]['status'] != 'Not yet aired') {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => InfoPage(
                                  anilistID: json[index]['id'].toString(),
                                ),
                                transition: Transition.rightToLeftWithFade,
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              json[index]['image']))),
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          40.0 -
                                          100.0 -
                                          12.0,
                                      child: Text(
                                        json[index]['title']['userPreferred'] !=
                                                null
                                            ? json[index]['title']
                                                ['userPreferred']
                                            : json[index]['id'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          40.0 -
                                          100.0 -
                                          12.0,
                                      child: Text(
                                        json[index]['releaseDate'].toString(),
                                        style: TextStyle(
                                          color: Color(0xff999999),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  })),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
