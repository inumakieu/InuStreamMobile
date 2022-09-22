import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inu_stream_ios/pages/home_page.dart';
import 'package:inu_stream_ios/pages/search_page.dart';
import 'package:inu_stream_ios/pages/watch_page.dart';
import 'package:isar/isar.dart';
import 'package:scroll_shadow_container/scroll_shadow_container.dart';
import 'package:google_fonts/google_fonts.dart';

import '../anime_settings.dart';

class InfoPage extends StatefulWidget {
  final String anilistID;
  final bool isScaffold;
  final dynamic searchedJson;
  const InfoPage({
    Key? key,
    required this.anilistID,
    this.isScaffold = false,
    required this.searchedJson,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool doneLoading = false;
  bool loadedSchema = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff16151A),
      body: Container(
        color: Color(0xff16151A),
        child: Stack(
          children: [
            FutureBuilder<http.Response>(
              future: http.get(Uri.parse(
                  'https://consumet-api.herokuapp.com/meta/anilist/info/${widget.anilistID}?provider=zoro')),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  default:
                    if (snapshot.hasData) {
                      var json = jsonDecode(snapshot.data!.body);
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6 -
                                          1,
                                  width: double.infinity,
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(json['cover'])),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff16151A),
                                        Color(0xff16151A).withOpacity(0.3),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: double.infinity,
                                  alignment: Alignment.bottomCenter,
                                  child: Hero(
                                    tag: json['id'],
                                    child: Container(
                                      height: 270.0,
                                      width: 170.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(json['image'])),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Hero(
                                    tag: json['id'] + json['title']['english'],
                                    child: Text(
                                      json['title']['english'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  json['title']['native'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.zenMaruGothic().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(30.0),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff1E222C),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: json['description']
                                      .replaceAll('\n', '')
                                      .toString()
                                      .replaceAll('<br>', '\n')
                                      .split('<i>')
                                      .map((e) {
                                    if (e.contains('</i>')) {
                                      return TextSpan(
                                        children: e
                                            .split('</i>')
                                            .asMap()
                                            .entries
                                            .map(
                                              (i) => i.key == 0
                                                  ? TextSpan(
                                                      text: i.value,
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  : TextSpan(
                                                      text: i.value,
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                            )
                                            .toList(),
                                      );
                                    } else {
                                      return TextSpan(text: e);
                                    }
                                  }).toList(),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20.0,
                                left: 30.0,
                                right: 30.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: json['nextAiringEpisode'] != null
                                        ? 190.0
                                        : MediaQuery.of(context).size.width -
                                            60.0,
                                    height: 40.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: json['genres'].length,
                                      itemBuilder: ((context, index) {
                                        return Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 22.0,
                                                  vertical: 12.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Text(
                                                json['genres'][index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                  json['nextAiringEpisode'] != null
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 8.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xffEE4546),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Text(
                                            'Episode ' +
                                                json['nextAiringEpisode']
                                                        ['episode']
                                                    .toString() +
                                                ':\n' +
                                                Duration(
                                                        seconds: json[
                                                                'nextAiringEpisode']
                                                            ['timeUntilAiring'])
                                                    .inDays
                                                    .toString() +
                                                ' days',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: loadedSchema == false
                                ? FutureBuilder<Isar>(
                                    future: Isar.open([AnimeSettingsSchema]),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        setState(() {
                                          loadedSchema = true;
                                        });
                                        final animeSettings =
                                            snapshot.data!.animeSettings;

                                        var anime =
                                            AnimeSettings(id: json['id']);
                                        anime.watched = [
                                          1,
                                          2,
                                        ];

                                        animeSettings.put(anime);
                                        print(animeSettings.get(json['id']));
                                        return EpisodeList(
                                          json: json,
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  )
                                : EpisodeList(
                                    json: json,
                                  ),
                          )
                        ],
                      );
                    } else {
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6 -
                                          1,
                                  width: double.infinity,
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          widget.searchedJson['cover'])),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff16151A),
                                        Color(0xff16151A).withOpacity(0.3),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: double.infinity,
                                  alignment: Alignment.bottomCenter,
                                  child: Hero(
                                    tag: widget.searchedJson['id'],
                                    child: Container(
                                      height: 270.0,
                                      width: 170.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              widget.searchedJson['image'])),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Hero(
                                    tag: widget.searchedJson['id'] +
                                        widget.searchedJson['title']['english'],
                                    child: Text(
                                      widget.searchedJson['title']['english'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.searchedJson['title']['native'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.zenMaruGothic().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(30.0),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff1E222C),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: widget.searchedJson['description']
                                      .replaceAll('\n', '')
                                      .toString()
                                      .replaceAll('<br>', '\n')
                                      .split('<i>')
                                      .map((e) {
                                    if (e.contains('</i>')) {
                                      return TextSpan(
                                        children: e
                                            .split('</i>')
                                            .asMap()
                                            .entries
                                            .map(
                                              (i) => i.key == 0
                                                  ? TextSpan(
                                                      text: i.value,
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  : TextSpan(
                                                      text: i.value,
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                            )
                                            .toList(),
                                      );
                                    } else {
                                      return TextSpan(text: e);
                                    }
                                  }).toList(),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                }
              },
            ),
            Positioned(
              top: 60.0,
              left: 20.0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EpisodeList extends StatefulWidget {
  dynamic json;
  EpisodeList({Key? key, required this.json}) : super(key: key);

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  late TextEditingController _textEditingController;
  int episodeNumber = -1;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Episodes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _textEditingController,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration.collapsed(
                        hintText: 'Episode...',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.7)),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value == '' ||
                              value == '0' ||
                              int.parse(value) >
                                  widget.json['episodes'].length) {
                            episodeNumber = -1;
                            _textEditingController.clear();
                          } else {
                            episodeNumber = int.parse(value);
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 600.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 26.0,
          ),
          alignment: Alignment.topCenter,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: episodeNumber == -1 ? widget.json['episodes'].length : 1,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => WatchPage(
                          episodeID: widget.json['episodes'][index +
                                  (episodeNumber != -1 ? episodeNumber - 1 : 0)]
                              ['id'],
                          json: widget.json,
                          episodeNumber: index +
                              (episodeNumber != -1 ? episodeNumber - 1 : 0),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 120.0,
                              height: 120 / 16 * 9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                                color: Colors.black,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.json['episodes'][
                                          index +
                                              (episodeNumber != -1
                                                  ? episodeNumber - 1
                                                  : 0)]['image'] ??
                                      '')),
                            ),
                            Container(
                              width: 120.0,
                              height: 120 / 16 * 9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(11.0),
                                        bottomRight: Radius.circular(12.0),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 3.0,
                                    ),
                                    child: Text(
                                      'Watched',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  /* Container(
                                    width: 120.0,
                                    height: 30.0,
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                      bottom: 4.0,
                                      right: 4.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff738CA5),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                        top: 2.0,
                                        right: 8.0,
                                        bottom: 4.0,
                                      ),
                                      child: Text(
                                        'Filler',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ) */
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 14.0,
                        ),
                        SizedBox(
                          height: 150 / 16 * 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  widget.json['episodes'][index +
                                          (episodeNumber != -1
                                              ? episodeNumber - 1
                                              : 0)]['title'] ??
                                      widget.json['title']['english'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Episode ${index + (episodeNumber != -1 ? episodeNumber : 1)}',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
