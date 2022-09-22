import 'dart:convert';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inu_stream_ios/pages/info_page.dart';

class FeaturedContent extends StatefulWidget {
  const FeaturedContent({
    super.key,
  });

  @override
  State<FeaturedContent> createState() => _FeaturedContentState();
}

class _FeaturedContentState extends State<FeaturedContent>
    with AutomaticKeepAliveClientMixin {
  int featuredSelectedIndex = 0;
  bool isWatchedHovered = false;
  bool isMyListHovered = false;

  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: http.get(Uri.parse(
          'https://consumet-api.herokuapp.com/meta/anilist/trending?provider=zoro')),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var featuredJson = json.decode(snapshot.data!.body)['results'];

          var featuredImages = [];
          var featuredEmbedFrame = [];
          for (var element in featuredJson) {
            featuredImages.add(element['cover']);
          }
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: SizedOverflowBox(
                      size: Size(double.infinity, 440.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider(
                              carouselController: _carouselController,
                              items: featuredImages.map((e) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Hero(
                                      tag: e.toString(),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                        margin: EdgeInsets.only(bottom: 10.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(e),
                                              filterQuality:
                                                  ui.FilterQuality.high,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xff16151A),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0,
                                              ],
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      featuredJson[featuredSelectedIndex]
                                                                  ['duration']
                                                              .toString() +
                                                          ' min / Episode',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            ui.FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.0,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Episodes: ',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0,
                                                              fontWeight: ui
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: featuredJson[
                                                                        featuredSelectedIndex]
                                                                    [
                                                                    'totalEpisodes']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xffDC1623),
                                                              fontSize: 14.0,
                                                              fontWeight: ui
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: ' - Status: ',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0,
                                                              fontWeight: ui
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                'CURRENTLY AIRING',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xffDC1623),
                                                              fontSize: 14.0,
                                                              fontWeight: ui
                                                                  .FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 2.0,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Text(
                                                        featuredJson[
                                                                    featuredSelectedIndex]
                                                                ['title']
                                                            ['userPreferred'],
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24.0,
                                                          fontWeight: ui
                                                              .FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            ui.TextAlign.start,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 6.0,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Text(
                                                        featuredJson[
                                                                    featuredSelectedIndex]
                                                                ['description']
                                                            .toString()
                                                            .replaceAll(
                                                                '<br>', '\n'),
                                                        maxLines: 10,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight: ui
                                                              .FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            ui.TextAlign.start,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 30.0,
                                                  top: 20.0,
                                                  right: 30.0,
                                                  bottom: 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(
                                                          () => InfoPage(
                                                            anilistID: featuredJson[
                                                                        featuredSelectedIndex]
                                                                    ['id']
                                                                .toString(),
                                                            searchedJson:
                                                                featuredJson[
                                                                    featuredSelectedIndex],
                                                          ),
                                                          transition: Transition
                                                              .rightToLeftWithFade,
                                                          curve: Curves.ease,
                                                        );
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        width: 100.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xff1AAEFE),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            35.0),
                                                                boxShadow:
                                                                    isWatchedHovered
                                                                        ? [
                                                                            BoxShadow(
                                                                              color: Color(0xff1AAEFE),
                                                                              blurRadius: 16.0,
                                                                            )
                                                                          ]
                                                                        : null),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .circleInfo,
                                                              color:
                                                                  Colors.white,
                                                              size: 22.0,
                                                            ),
                                                            SizedBox(
                                                              width: 12.0,
                                                            ),
                                                            Text(
                                                              'INFO',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                fontWeight: ui
                                                                    .FontWeight
                                                                    .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    MouseRegion(
                                                      onEnter: (e) {
                                                        setState(() {
                                                          isMyListHovered =
                                                              true;
                                                        });
                                                      },
                                                      onExit: (e) {
                                                        setState(() {
                                                          isMyListHovered =
                                                              false;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        width: 40.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            35.0),
                                                                boxShadow:
                                                                    isMyListHovered
                                                                        ? [
                                                                            BoxShadow(
                                                                              color: Colors.black,
                                                                              blurRadius: 16.0,
                                                                            )
                                                                          ]
                                                                        : null),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .plus,
                                                              color:
                                                                  Colors.white,
                                                              size: 16.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                enlargeCenterPage: false,
                                clipBehavior: ui.Clip.antiAlias,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    featuredSelectedIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: featuredImages.map(
                      (image) {
                        //these two lines
                        int index = featuredImages.indexOf(image); //are changed
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: featuredSelectedIndex == index
                                ? Color(0xffF44336)
                                : Colors.white,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const SizedBox(
            height: 500.0,
          );
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
