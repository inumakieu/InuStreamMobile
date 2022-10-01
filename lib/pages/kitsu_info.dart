import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';

import '../anime_settings.dart';
import '../components/episode_list.dart';

class KitsuInfo extends StatefulWidget {
  final String kitsuId;
  const KitsuInfo({
    super.key,
    required this.kitsuId,
  });

  @override
  State<KitsuInfo> createState() => _KitsuInfoState();
}

class _KitsuInfoState extends State<KitsuInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff16151A),
      body: FutureBuilder<http.Response>(
        future: http.get(
            Uri.parse('https://kitsu.io/api/edge/anime/${widget.kitsuId}'),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/vnd.api+json'
            }),
        builder: (context, response) {
          if (response.hasData) {
            var animeJson = jsonDecode(utf8.decode(response.data!.bodyBytes));
            print(animeJson['data']['attributes']['titles']);
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6 - 1,
                        child: Image(
                          image: NetworkImage(
                            animeJson['data']['attributes']['coverImage']
                                ['original'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color(0xff16151A),
                            ],
                            stops: [0.0, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 270.0,
                          width: 170.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image(
                            image: NetworkImage(
                              animeJson['data']['attributes']['posterImage']
                                  ['original'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          animeJson['data']['attributes']['titles']['en'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          animeJson['data']['attributes']['titles']['ja_jp'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: GoogleFonts.zenMaruGothic().fontFamily,
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 60.0,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Color(0xff1E222C),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        animeJson['data']['attributes']['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FutureBuilder<http.Response>(
                    future: http.get(Uri.parse(
                        'https://consumet-api.herokuapp.com/meta/anilist/info/98659?provider=zoro')),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var json = jsonDecode(snapshot.data!.body);
                        return EpisodeList(
                          json: json,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
