import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../anime_settings.dart';
import '../pages/watch_page.dart';

class EpisodeList extends StatefulWidget {
  dynamic json;
  Future<AnimeSettings?>? animeSetting;
  Isar? isar;
  EpisodeList({
    Key? key,
    required this.json,
    this.animeSetting,
    this.isar,
  }) : super(key: key);

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
                  width: 140.0,
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
        FutureBuilder<AnimeSettings?>(
          future: widget.animeSetting,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data!.watched);
              return Container(
                width: double.infinity,
                height: 600.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26.0,
                ),
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount:
                      episodeNumber == -1 ? widget.json['episodes'].length : 1,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<int> watchedList = [];
                            watchedList.addAll(snapshot.data!.watched!);

                            watchedList.add(index +
                                (episodeNumber != -1 ? episodeNumber - 1 : 0) +
                                1);

                            AnimeSettings anime =
                                AnimeSettings(id: int.parse(widget.json['id']))
                                  ..watched = watchedList;

                            widget.isar!.writeTxn(() async {
                              await widget.isar!.animeSettings.put(anime);
                            });

                            Get.to(
                              () => WatchPage(
                                episodeID: widget.json['episodes'][index +
                                    (episodeNumber != -1
                                        ? episodeNumber - 1
                                        : 0)]['id'],
                                json: widget.json,
                                episodeNumber: index +
                                    (episodeNumber != -1
                                        ? episodeNumber - 1
                                        : 0),
                                animeSettings: snapshot.data,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 140.0,
                                    height: 140 / 16 * 9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                      color: Colors.black,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            widget.json['episodes'][index +
                                                    (episodeNumber != -1
                                                        ? episodeNumber - 1
                                                        : 0)]['image'] ??
                                                '')),
                                  ),
                                  Container(
                                    width: 140.0,
                                    height: 140 / 16 * 9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        snapshot.data!.watched!
                                                .contains(index + 1)
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(11.0),
                                                    bottomRight:
                                                        Radius.circular(12.0),
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
                                              )
                                            : SizedBox.shrink(),
                                        widget.json['episodes'][index +
                                                        (episodeNumber != -1
                                                            ? episodeNumber - 1
                                                            : 0)]['isFiller'] !=
                                                    null &&
                                                widget.json['episodes'][index +
                                                    (episodeNumber != -1
                                                        ? episodeNumber - 1
                                                        : 0)]['isFiller']
                                            ? Container(
                                                width: 140.0,
                                                height: 30.0,
                                                alignment:
                                                    Alignment.centerRight,
                                                padding: EdgeInsets.only(
                                                  bottom: 4.0,
                                                  right: 4.0,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff738CA5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink()
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
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
              );
            } else {
              return Container(
                width: double.infinity,
                height: 600.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26.0,
                ),
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount:
                      episodeNumber == -1 ? widget.json['episodes'].length : 1,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => WatchPage(
                                episodeID: widget.json['episodes'][index +
                                    (episodeNumber != -1
                                        ? episodeNumber - 1
                                        : 0)]['id'],
                                json: widget.json,
                                episodeNumber: index +
                                    (episodeNumber != -1
                                        ? episodeNumber - 1
                                        : 0),
                                animeSettings: snapshot.data,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 140.0,
                                    height: 140 / 16 * 9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                      color: Colors.black,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            widget.json['episodes'][index +
                                                    (episodeNumber != -1
                                                        ? episodeNumber - 1
                                                        : 0)]['image'] ??
                                                '')),
                                  ),
                                  widget.json['episodes'][index +
                                                  (episodeNumber != -1
                                                      ? episodeNumber - 1
                                                      : 0)]['isFiller'] !=
                                              null &&
                                          widget.json['episodes'][index +
                                              (episodeNumber != -1
                                                  ? episodeNumber - 1
                                                  : 0)]['isFiller']
                                      ? Container(
                                          width: 140.0,
                                          height: 140 / 16 * 9,
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            width: 140.0,
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
                                          ),
                                        )
                                      : SizedBox.shrink()
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
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
                          height: 8.0,
                        ),
                      ],
                    );
                  }),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
