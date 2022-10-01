import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InfoPage extends StatefulWidget {
  final String id;
  const InfoPage({
    super.key,
    required this.id,
  });

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<http.Response>(
        future: http.get(Uri.parse(
            'https://consumet-api.herokuapp.com/meta/anilist/info/${widget.id}?provider=zoro')),
        builder: ((context, response) {
          if (response.hasData) {
            var animeData = jsonDecode(response.data!.body);
            return Center(
              child: Text(animeData['title']['english'] ??
                  animeData['title']['romaji']),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
