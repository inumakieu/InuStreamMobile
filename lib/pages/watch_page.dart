import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inu_stream_ios/custom_controls.dart';
import 'package:subtitle/subtitle.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:chewie/chewie.dart' as chewie;

class EpisodeSources {
  final String url;
  final String quality;
  final bool isM3U8;

  const EpisodeSources({
    required this.url,
    required this.quality,
    required this.isM3U8,
  });

  factory EpisodeSources.fromJson(Map<String, dynamic> json) {
    return EpisodeSources(
      url: json['url'],
      quality: json['quality'],
      isM3U8: json['isM3U8'],
    );
  }
}

class EpisodeSubtitles {
  final String url;
  final String lang;

  const EpisodeSubtitles({
    required this.url,
    required this.lang,
  });

  factory EpisodeSubtitles.fromJson(Map<String, dynamic> json) {
    return EpisodeSubtitles(
      url: json['url'],
      lang: json['lang'],
    );
  }
}

class EpisodeDetails {
  final EpisodeSources sources;
  final EpisodeSubtitles subtitles;

  const EpisodeDetails({
    required this.sources,
    required this.subtitles,
  });

  factory EpisodeDetails.fromJson(Map<String, dynamic> json) {
    return EpisodeDetails(
      sources: EpisodeSources.fromJson(json['sources'][0]),
      subtitles: EpisodeSubtitles.fromJson(json['subtitles'][1]),
    );
  }
}

class WatchPage extends StatefulWidget {
  final String episodeID;
  final dynamic json;
  final int episodeNumber;
  const WatchPage({
    Key? key,
    required this.episodeID,
    this.json,
    this.episodeNumber = -1,
  }) : super(key: key);

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late SubtitleController subtitleController;

  ValueNotifier<int> selectedSubtitle = ValueNotifier(1);

  Subtitles subtitleList = Subtitles([]);

  bool finishedLoading = false;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network('');
    _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      fullScreenByDefault: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
      customControls: CustomControls(
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
        selectedSubtitle: selectedSubtitle,
        json: widget.json,
        episodeNumber: widget.episodeNumber,
        episodeJson: jsonDecode('{}'),
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    selectedSubtitle.dispose();
    super.dispose();
  }

  Future<http.Response> getEpisodeJson() {
    return http.get(Uri.parse(
        'https://consumet-api.herokuapp.com/meta/anilist/watch/${widget.episodeID}?provider=zoro'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !finishedLoading
          ? FutureBuilder<http.Response>(
              future: getEpisodeJson(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var episode =
                      EpisodeDetails.fromJson(jsonDecode(snapshot.data!.body));

                  var subs = jsonDecode(snapshot.data!.body)['subtitles'];

                  var i = 0;
                  for (var subtitle in subs) {
                    if (subtitle['lang'] == 'English') {
                      selectedSubtitle.value = i;
                      break;
                    }
                    i++;
                  }

                  subtitleController = SubtitleController(
                    provider: SubtitleProvider.fromNetwork(
                      Uri.parse(
                        subs[selectedSubtitle.value]['url'],
                      ),
                    ),
                  );
                  subtitleController.initial().whenComplete(() {
                    setState(() {
                      _videoPlayerController =
                          VideoPlayerController.network(episode.sources.url);
                      _videoPlayerController.initialize();

                      subtitleList = Subtitles(subtitleController.subtitles
                          .map((e) => chewie.Subtitle(
                              index: e.index,
                              start: e.start,
                              end: e.end,
                              text: e.data))
                          .toList());

                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController,
                        aspectRatio: 16 / 9,
                        fullScreenByDefault: true,
                        customControls: CustomControls(
                          backgroundColor: Colors.transparent,
                          iconColor: Colors.white,
                          selectedSubtitle: selectedSubtitle,
                          json: widget.json,
                          episodeNumber: widget.episodeNumber,
                          episodeJson: jsonDecode(snapshot.data!.body),
                        ),
                        errorBuilder: (context, errorMessage) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        additionalOptions: (context) {
                          List<OptionItem> optionsList = [];
                          for (var i = 0;
                              i <
                                  jsonDecode(snapshot.data!.body)['subtitles']
                                          .length -
                                      1;
                              i++) {
                            optionsList.add(OptionItem(
                              onTap: () => setState(() {
                                selectedSubtitle.value = i;
                                subtitleController = SubtitleController(
                                  provider: SubtitleProvider.fromNetwork(
                                    Uri.parse(
                                      jsonDecode(snapshot.data!.body)[
                                          'subtitles'][i]['url'],
                                    ),
                                  ),
                                );
                                // ignore: void_checks
                                subtitleController.initial().whenComplete(() {
                                  setState(() {
                                    _chewieController.subtitle =
                                        Subtitles(subtitleController.subtitles
                                            .map(
                                              (e) => chewie.Subtitle(
                                                  index: e.index,
                                                  start: e.start,
                                                  end: e.end,
                                                  text: e.data),
                                            )
                                            .toList());
                                  });
                                });
                              }),
                              iconData: Icons.chat,
                              title:
                                  jsonDecode(snapshot.data!.body)['subtitles']
                                      [i]['lang'],
                            ));
                          }

                          return optionsList;
                        },
                        subtitle: subtitleList,
                        subtitleBuilder: (context, subtitle) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 2.0,
                                  left: 2.0,
                                ),
                                child: BorderedText(
                                  strokeWidth: 4.0,
                                  strokeColor: Colors.black,
                                  child: Text(
                                    subtitle,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24.0,
                                      fontFamily: 'Trebuchet MS',
                                    ),
                                  ),
                                ),
                              ),
                              BorderedText(
                                strokeWidth: 4.0,
                                strokeColor: Colors.black,
                                child: Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontFamily: 'Trebuchet MS',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      finishedLoading = true;
                    });
                  });
                  return SafeArea(
                    maintainBottomViewPadding: true,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  );
                } else {
                  return SafeArea(
                    maintainBottomViewPadding: true,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  );
                }
              },
            )
          : SafeArea(
              maintainBottomViewPadding: true,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
    );
  }
}
