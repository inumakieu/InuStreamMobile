import 'package:isar/isar.dart';

part 'anime_settings.g.dart';

@collection
class AnimeSettings {
  // Anilist ID
  Id id;

  // watched episodes list
  List<int>? watched;

  // progress map
  List<double>? progress;

  AnimeSettings({
    required this.id,
    this.watched,
    this.progress,
  });
}
