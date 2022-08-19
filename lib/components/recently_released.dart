import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inu_stream_ios/pages/watch_page.dart';

class RecentlyReleased extends StatefulWidget {
  final dynamic recentJson;
  const RecentlyReleased({
    Key? key,
    required this.recentJson,
  }) : super(key: key);

  @override
  State<RecentlyReleased> createState() => _RecentlyReleasedState();
}

class _RecentlyReleasedState extends State<RecentlyReleased> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.0),
      height: 240.0,
      width: double.infinity,
      //color: Colors.deepPurple,
      child: ListView.builder(
          itemCount: widget.recentJson.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (_selectedIndex == index) {
                      /* Get.to(
                        () => WatchPage(
                          episodeID: episodeIDString,
                        ),
                      ); */
                    } else {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                    clipBehavior: Clip.antiAlias,
                    width: _selectedIndex == index ? 160.0 : 110.0,
                    height: _selectedIndex == index ? 210.0 : 160.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        _selectedIndex == index ? 20.0 : 12.0,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.recentJson[index]['image']),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                                stops: [
                                  0.00,
                                  0.4,
                                  1,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.recentJson[index]['episode'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          width: double.infinity,
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              widget.recentJson[index]['title'],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
              ],
            );
          })),
    );
  }
}
