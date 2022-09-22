// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, avoid_js_rounded_ints, prefer_final_locals

extension GetAnimeSettingsCollection on Isar {
  IsarCollection<AnimeSettings> get animeSettings => this.collection();
}

const AnimeSettingsSchema = CollectionSchema(
  name: r'AnimeSettings',
  id: -5015606025901581259,
  properties: {
    r'progress': PropertySchema(
      id: 0,
      name: r'progress',
      type: IsarType.doubleList,
    ),
    r'watched': PropertySchema(
      id: 1,
      name: r'watched',
      type: IsarType.longList,
    )
  },
  estimateSize: _animeSettingsEstimateSize,
  serializeNative: _animeSettingsSerializeNative,
  deserializeNative: _animeSettingsDeserializeNative,
  deserializePropNative: _animeSettingsDeserializePropNative,
  serializeWeb: _animeSettingsSerializeWeb,
  deserializeWeb: _animeSettingsDeserializeWeb,
  deserializePropWeb: _animeSettingsDeserializePropWeb,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _animeSettingsGetId,
  getLinks: _animeSettingsGetLinks,
  attach: _animeSettingsAttach,
  version: '3.0.0-dev.14',
);

int _animeSettingsEstimateSize(
  AnimeSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.progress;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.watched;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

int _animeSettingsSerializeNative(
  AnimeSettings object,
  IsarBinaryWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDoubleList(offsets[0], object.progress);
  writer.writeLongList(offsets[1], object.watched);
  return writer.usedBytes;
}

AnimeSettings _animeSettingsDeserializeNative(
  Id id,
  IsarBinaryReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnimeSettings(
    id: id,
    progress: reader.readDoubleList(offsets[0]),
    watched: reader.readLongList(offsets[1]),
  );
  return object;
}

P _animeSettingsDeserializePropNative<P>(
  IsarBinaryReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleList(offset)) as P;
    case 1:
      return (reader.readLongList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Object _animeSettingsSerializeWeb(
    IsarCollection<AnimeSettings> collection, AnimeSettings object) {
  /*final jsObj = IsarNative.newJsObject();*/ throw UnimplementedError();
}

AnimeSettings _animeSettingsDeserializeWeb(
    IsarCollection<AnimeSettings> collection, Object jsObj) {
  /*final object = AnimeSettings(id: IsarNative.jsObjectGet(jsObj, r'id') ?? (double.negativeInfinity as int),progress: (IsarNative.jsObjectGet(jsObj, r'progress') as List?)?.map((e) => e ?? double.negativeInfinity).toList().cast<double>() ,watched: (IsarNative.jsObjectGet(jsObj, r'watched') as List?)?.map((e) => e ?? (double.negativeInfinity as int)).toList().cast<int>() ,);*/
  //return object;
  throw UnimplementedError();
}

P _animeSettingsDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    default:
      throw IsarError('Illegal propertyName');
  }
}

Id _animeSettingsGetId(AnimeSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _animeSettingsGetLinks(AnimeSettings object) {
  return [];
}

void _animeSettingsAttach(
    IsarCollection<dynamic> col, Id id, AnimeSettings object) {
  object.id = id;
}

extension AnimeSettingsQueryWhereSort
    on QueryBuilder<AnimeSettings, AnimeSettings, QWhere> {
  QueryBuilder<AnimeSettings, AnimeSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnimeSettingsQueryWhere
    on QueryBuilder<AnimeSettings, AnimeSettings, QWhereClause> {
  QueryBuilder<AnimeSettings, AnimeSettings, QAfterWhereClause> idEqualTo(
      int id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterWhereClause> idNotEqualTo(
      int id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnimeSettingsQueryFilter
    on QueryBuilder<AnimeSettings, AnimeSettings, QFilterCondition> {
  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition> idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'progress',
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'progress',
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'progress',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'progress',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'progress',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'progress',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'progress',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      progressLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'progress',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'watched',
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'watched',
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watched',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'watched',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'watched',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'watched',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watched',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watched',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watched',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watched',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watched',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterFilterCondition>
      watchedLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watched',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension AnimeSettingsQueryObject
    on QueryBuilder<AnimeSettings, AnimeSettings, QFilterCondition> {}

extension AnimeSettingsQueryLinks
    on QueryBuilder<AnimeSettings, AnimeSettings, QFilterCondition> {}

extension AnimeSettingsQuerySortBy
    on QueryBuilder<AnimeSettings, AnimeSettings, QSortBy> {}

extension AnimeSettingsQuerySortThenBy
    on QueryBuilder<AnimeSettings, AnimeSettings, QSortThenBy> {
  QueryBuilder<AnimeSettings, AnimeSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension AnimeSettingsQueryWhereDistinct
    on QueryBuilder<AnimeSettings, AnimeSettings, QDistinct> {
  QueryBuilder<AnimeSettings, AnimeSettings, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<AnimeSettings, AnimeSettings, QDistinct> distinctByWatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'watched');
    });
  }
}

extension AnimeSettingsQueryProperty
    on QueryBuilder<AnimeSettings, AnimeSettings, QQueryProperty> {
  QueryBuilder<AnimeSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnimeSettings, List<double>?, QQueryOperations>
      progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<AnimeSettings, List<int>?, QQueryOperations> watchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'watched');
    });
  }
}
