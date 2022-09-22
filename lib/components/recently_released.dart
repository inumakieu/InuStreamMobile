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
      margin: EdgeInsets.only(left: 30.0),
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
                    Get.to(
                      () => WatchPage(
                        episodeID: widget.recentJson[index]['id'],
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease,
                        clipBehavior: Clip.antiAlias,
                        width: 140.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(widget.recentJson[index]['image']),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: 140.0,
                        child: Text(
                          widget.recentJson[index]['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        'Episode ' +
                            widget.recentJson[index]['episode'].toString(),
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            );
          })),
    );
  }
}
