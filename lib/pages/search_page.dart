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
              color: Color(0xff1F212B),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 20.0,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for an Anime...',
                  hintStyle: TextStyle(
                    color: Color(0xff818181),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  )),
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
                    if (json[index]['status'] != 'Not yet aired' &&
                        json[index]['releaseDate'] != null &&
                        json[index]['cover'] != null) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => InfoPage(
                                  anilistID: json[index]['id'].toString(),
                                  searchedJson: json[index],
                                ),
                                transition: Transition.rightToLeftWithFade,
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              children: [
                                Hero(
                                  tag: json[index]['id'],
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        json[index]['image'],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40.0 -
                                                100.0 -
                                                12.0,
                                        height: 70.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                json[index]['cover'],
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black,
                                              Colors.black,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [
                                              0.0,
                                              0.5,
                                              1.0,
                                            ],
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40.0 -
                                                  100.0 -
                                                  32.0,
                                              child: Hero(
                                                tag: json[index]['id']
                                                        .toString() +
                                                    json[index]['title']
                                                            ['english']
                                                        .toString(),
                                                child: Text(
                                                  json[index]['title']
                                                          ['english'] ??
                                                      json[index]['title']
                                                          ['romaji'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.0,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40.0 -
                                                  100.0 -
                                                  32.0,
                                              child: Text(
                                                json[index]['description']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 8.0,
                                                ),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.0,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40.0 -
                                                  100.0 -
                                                  32.0,
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff1F212B),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 14.0,
                                                  vertical: 6.0,
                                                ),
                                                child: Text(
                                                  json[index]['status'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40.0 -
                                                100.0 -
                                                12.0,
                                        height: 24.0,
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20.0))),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 14.0,
                                                vertical: 6.0,
                                              ),
                                              child: Text(
                                                'Rating: ' +
                                                    (json[index]['rating'] / 10)
                                                        .toString() +
                                                    ' / 10',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                json[index]['totalEpisodes']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
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
