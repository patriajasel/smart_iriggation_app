// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScheduleCollection on Isar {
  IsarCollection<Schedule> get schedules => this.collection();
}

const ScheduleSchema = CollectionSchema(
  name: r'Schedule',
  id: 6369058706800408146,
  properties: {
    r'day': PropertySchema(
      id: 0,
      name: r'day',
      type: IsarType.string,
    ),
    r'nodeNum': PropertySchema(
      id: 1,
      name: r'nodeNum',
      type: IsarType.long,
    ),
    r'time': PropertySchema(
      id: 2,
      name: r'time',
      type: IsarType.string,
    ),
    r'waterAmount': PropertySchema(
      id: 3,
      name: r'waterAmount',
      type: IsarType.long,
    )
  },
  estimateSize: _scheduleEstimateSize,
  serialize: _scheduleSerialize,
  deserialize: _scheduleDeserialize,
  deserializeProp: _scheduleDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _scheduleGetId,
  getLinks: _scheduleGetLinks,
  attach: _scheduleAttach,
  version: '3.1.0+1',
);

int _scheduleEstimateSize(
  Schedule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.day.length * 3;
  bytesCount += 3 + object.time.length * 3;
  return bytesCount;
}

void _scheduleSerialize(
  Schedule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.day);
  writer.writeLong(offsets[1], object.nodeNum);
  writer.writeString(offsets[2], object.time);
  writer.writeLong(offsets[3], object.waterAmount);
}

Schedule _scheduleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Schedule();
  object.day = reader.readString(offsets[0]);
  object.id = id;
  object.nodeNum = reader.readLong(offsets[1]);
  object.time = reader.readString(offsets[2]);
  object.waterAmount = reader.readLong(offsets[3]);
  return object;
}

P _scheduleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _scheduleGetId(Schedule object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scheduleGetLinks(Schedule object) {
  return [];
}

void _scheduleAttach(IsarCollection<dynamic> col, Id id, Schedule object) {
  object.id = id;
}

extension ScheduleQueryWhereSort on QueryBuilder<Schedule, Schedule, QWhere> {
  QueryBuilder<Schedule, Schedule, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ScheduleQueryWhere on QueryBuilder<Schedule, Schedule, QWhereClause> {
  QueryBuilder<Schedule, Schedule, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Schedule, Schedule, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
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

extension ScheduleQueryFilter
    on QueryBuilder<Schedule, Schedule, QFilterCondition> {
  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'day',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'day',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'day',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: '',
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> dayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'day',
        value: '',
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> nodeNumEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeNum',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> nodeNumGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nodeNum',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> nodeNumLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nodeNum',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> nodeNumBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nodeNum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'time',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'time',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'time',
        value: '',
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> waterAmountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition>
      waterAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> waterAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> waterAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ScheduleQueryObject
    on QueryBuilder<Schedule, Schedule, QFilterCondition> {}

extension ScheduleQueryLinks
    on QueryBuilder<Schedule, Schedule, QFilterCondition> {}

extension ScheduleQuerySortBy on QueryBuilder<Schedule, Schedule, QSortBy> {
  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByNodeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByNodeNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByWaterAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.desc);
    });
  }
}

extension ScheduleQuerySortThenBy
    on QueryBuilder<Schedule, Schedule, QSortThenBy> {
  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByNodeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByNodeNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByWaterAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.desc);
    });
  }
}

extension ScheduleQueryWhereDistinct
    on QueryBuilder<Schedule, Schedule, QDistinct> {
  QueryBuilder<Schedule, Schedule, QDistinct> distinctByDay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'day', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Schedule, Schedule, QDistinct> distinctByNodeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nodeNum');
    });
  }

  QueryBuilder<Schedule, Schedule, QDistinct> distinctByTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Schedule, Schedule, QDistinct> distinctByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterAmount');
    });
  }
}

extension ScheduleQueryProperty
    on QueryBuilder<Schedule, Schedule, QQueryProperty> {
  QueryBuilder<Schedule, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Schedule, String, QQueryOperations> dayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'day');
    });
  }

  QueryBuilder<Schedule, int, QQueryOperations> nodeNumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodeNum');
    });
  }

  QueryBuilder<Schedule, String, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<Schedule, int, QQueryOperations> waterAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterAmount');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeeksCollection on Isar {
  IsarCollection<Weeks> get weeks => this.collection();
}

const WeeksSchema = CollectionSchema(
  name: r'Weeks',
  id: -8040093497685263702,
  properties: {
    r'crop': PropertySchema(
      id: 0,
      name: r'crop',
      type: IsarType.string,
    ),
    r'waterAmount': PropertySchema(
      id: 1,
      name: r'waterAmount',
      type: IsarType.string,
    ),
    r'week': PropertySchema(
      id: 2,
      name: r'week',
      type: IsarType.string,
    )
  },
  estimateSize: _weeksEstimateSize,
  serialize: _weeksSerialize,
  deserialize: _weeksDeserialize,
  deserializeProp: _weeksDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _weeksGetId,
  getLinks: _weeksGetLinks,
  attach: _weeksAttach,
  version: '3.1.0+1',
);

int _weeksEstimateSize(
  Weeks object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.crop.length * 3;
  bytesCount += 3 + object.waterAmount.length * 3;
  bytesCount += 3 + object.week.length * 3;
  return bytesCount;
}

void _weeksSerialize(
  Weeks object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.crop);
  writer.writeString(offsets[1], object.waterAmount);
  writer.writeString(offsets[2], object.week);
}

Weeks _weeksDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Weeks();
  object.crop = reader.readString(offsets[0]);
  object.id = id;
  object.waterAmount = reader.readString(offsets[1]);
  object.week = reader.readString(offsets[2]);
  return object;
}

P _weeksDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weeksGetId(Weeks object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weeksGetLinks(Weeks object) {
  return [];
}

void _weeksAttach(IsarCollection<dynamic> col, Id id, Weeks object) {
  object.id = id;
}

extension WeeksQueryWhereSort on QueryBuilder<Weeks, Weeks, QWhere> {
  QueryBuilder<Weeks, Weeks, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WeeksQueryWhere on QueryBuilder<Weeks, Weeks, QWhereClause> {
  QueryBuilder<Weeks, Weeks, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Weeks, Weeks, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
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

extension WeeksQueryFilter on QueryBuilder<Weeks, Weeks, QFilterCondition> {
  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'crop',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'crop',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'crop',
        value: '',
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> cropIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'crop',
        value: '',
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'waterAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'waterAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'waterAmount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'waterAmount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> waterAmountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'waterAmount',
        value: '',
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'week',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'week',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'week',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'week',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'week',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'week',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'week',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'week',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'week',
        value: '',
      ));
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterFilterCondition> weekIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'week',
        value: '',
      ));
    });
  }
}

extension WeeksQueryObject on QueryBuilder<Weeks, Weeks, QFilterCondition> {}

extension WeeksQueryLinks on QueryBuilder<Weeks, Weeks, QFilterCondition> {}

extension WeeksQuerySortBy on QueryBuilder<Weeks, Weeks, QSortBy> {
  QueryBuilder<Weeks, Weeks, QAfterSortBy> sortByCrop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.asc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> sortByCropDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.desc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> sortByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.asc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> sortByWaterAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.desc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> sortByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> sortByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }
}

extension WeeksQuerySortThenBy on QueryBuilder<Weeks, Weeks, QSortThenBy> {
  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenByCrop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.asc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenByCropDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.desc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.asc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenByWaterAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.desc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<Weeks, Weeks, QAfterSortBy> thenByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }
}

extension WeeksQueryWhereDistinct on QueryBuilder<Weeks, Weeks, QDistinct> {
  QueryBuilder<Weeks, Weeks, QDistinct> distinctByCrop(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'crop', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Weeks, Weeks, QDistinct> distinctByWaterAmount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterAmount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Weeks, Weeks, QDistinct> distinctByWeek(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'week', caseSensitive: caseSensitive);
    });
  }
}

extension WeeksQueryProperty on QueryBuilder<Weeks, Weeks, QQueryProperty> {
  QueryBuilder<Weeks, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Weeks, String, QQueryOperations> cropProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'crop');
    });
  }

  QueryBuilder<Weeks, String, QQueryOperations> waterAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterAmount');
    });
  }

  QueryBuilder<Weeks, String, QQueryOperations> weekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'week');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStagesCollection on Isar {
  IsarCollection<Stages> get stages => this.collection();
}

const StagesSchema = CollectionSchema(
  name: r'Stages',
  id: 6913235863760775019,
  properties: {
    r'crop': PropertySchema(
      id: 0,
      name: r'crop',
      type: IsarType.string,
    ),
    r'period': PropertySchema(
      id: 1,
      name: r'period',
      type: IsarType.string,
    )
  },
  estimateSize: _stagesEstimateSize,
  serialize: _stagesSerialize,
  deserialize: _stagesDeserialize,
  deserializeProp: _stagesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'weeks': LinkSchema(
      id: 3809258461056321220,
      name: r'weeks',
      target: r'Weeks',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _stagesGetId,
  getLinks: _stagesGetLinks,
  attach: _stagesAttach,
  version: '3.1.0+1',
);

int _stagesEstimateSize(
  Stages object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.crop.length * 3;
  bytesCount += 3 + object.period.length * 3;
  return bytesCount;
}

void _stagesSerialize(
  Stages object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.crop);
  writer.writeString(offsets[1], object.period);
}

Stages _stagesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stages();
  object.crop = reader.readString(offsets[0]);
  object.id = id;
  object.period = reader.readString(offsets[1]);
  return object;
}

P _stagesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stagesGetId(Stages object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stagesGetLinks(Stages object) {
  return [object.weeks];
}

void _stagesAttach(IsarCollection<dynamic> col, Id id, Stages object) {
  object.id = id;
  object.weeks.attach(col, col.isar.collection<Weeks>(), r'weeks', id);
}

extension StagesQueryWhereSort on QueryBuilder<Stages, Stages, QWhere> {
  QueryBuilder<Stages, Stages, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StagesQueryWhere on QueryBuilder<Stages, Stages, QWhereClause> {
  QueryBuilder<Stages, Stages, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Stages, Stages, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Stages, Stages, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Stages, Stages, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
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

extension StagesQueryFilter on QueryBuilder<Stages, Stages, QFilterCondition> {
  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'crop',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'crop',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'crop',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'crop',
        value: '',
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> cropIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'crop',
        value: '',
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<Stages, Stages, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<Stages, Stages, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'period',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'period',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'period',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'period',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'period',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'period',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'period',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'period',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'period',
        value: '',
      ));
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> periodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'period',
        value: '',
      ));
    });
  }
}

extension StagesQueryObject on QueryBuilder<Stages, Stages, QFilterCondition> {}

extension StagesQueryLinks on QueryBuilder<Stages, Stages, QFilterCondition> {
  QueryBuilder<Stages, Stages, QAfterFilterCondition> weeks(
      FilterQuery<Weeks> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'weeks');
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> weeksLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weeks', length, true, length, true);
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> weeksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weeks', 0, true, 0, true);
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> weeksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weeks', 0, false, 999999, true);
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> weeksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weeks', 0, true, length, include);
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> weeksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weeks', length, include, 999999, true);
    });
  }

  QueryBuilder<Stages, Stages, QAfterFilterCondition> weeksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'weeks', lower, includeLower, upper, includeUpper);
    });
  }
}

extension StagesQuerySortBy on QueryBuilder<Stages, Stages, QSortBy> {
  QueryBuilder<Stages, Stages, QAfterSortBy> sortByCrop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.asc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> sortByCropDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.desc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> sortByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> sortByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }
}

extension StagesQuerySortThenBy on QueryBuilder<Stages, Stages, QSortThenBy> {
  QueryBuilder<Stages, Stages, QAfterSortBy> thenByCrop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.asc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> thenByCropDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'crop', Sort.desc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> thenByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<Stages, Stages, QAfterSortBy> thenByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }
}

extension StagesQueryWhereDistinct on QueryBuilder<Stages, Stages, QDistinct> {
  QueryBuilder<Stages, Stages, QDistinct> distinctByCrop(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'crop', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Stages, Stages, QDistinct> distinctByPeriod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'period', caseSensitive: caseSensitive);
    });
  }
}

extension StagesQueryProperty on QueryBuilder<Stages, Stages, QQueryProperty> {
  QueryBuilder<Stages, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Stages, String, QQueryOperations> cropProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'crop');
    });
  }

  QueryBuilder<Stages, String, QQueryOperations> periodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'period');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCropInformationCollection on Isar {
  IsarCollection<CropInformation> get cropInformations => this.collection();
}

const CropInformationSchema = CollectionSchema(
  name: r'CropInformation',
  id: 2067690488350995795,
  properties: {
    r'cropDescription': PropertySchema(
      id: 0,
      name: r'cropDescription',
      type: IsarType.string,
    ),
    r'cropName': PropertySchema(
      id: 1,
      name: r'cropName',
      type: IsarType.string,
    ),
    r'pictureDir': PropertySchema(
      id: 2,
      name: r'pictureDir',
      type: IsarType.string,
    ),
    r'soilType': PropertySchema(
      id: 3,
      name: r'soilType',
      type: IsarType.string,
    )
  },
  estimateSize: _cropInformationEstimateSize,
  serialize: _cropInformationSerialize,
  deserialize: _cropInformationDeserialize,
  deserializeProp: _cropInformationDeserializeProp,
  idName: r'cropID',
  indexes: {},
  links: {
    r'stages': LinkSchema(
      id: -8658107942845158033,
      name: r'stages',
      target: r'Stages',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _cropInformationGetId,
  getLinks: _cropInformationGetLinks,
  attach: _cropInformationAttach,
  version: '3.1.0+1',
);

int _cropInformationEstimateSize(
  CropInformation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cropDescription.length * 3;
  bytesCount += 3 + object.cropName.length * 3;
  bytesCount += 3 + object.pictureDir.length * 3;
  bytesCount += 3 + object.soilType.length * 3;
  return bytesCount;
}

void _cropInformationSerialize(
  CropInformation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cropDescription);
  writer.writeString(offsets[1], object.cropName);
  writer.writeString(offsets[2], object.pictureDir);
  writer.writeString(offsets[3], object.soilType);
}

CropInformation _cropInformationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CropInformation();
  object.cropDescription = reader.readString(offsets[0]);
  object.cropID = id;
  object.cropName = reader.readString(offsets[1]);
  object.pictureDir = reader.readString(offsets[2]);
  object.soilType = reader.readString(offsets[3]);
  return object;
}

P _cropInformationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cropInformationGetId(CropInformation object) {
  return object.cropID;
}

List<IsarLinkBase<dynamic>> _cropInformationGetLinks(CropInformation object) {
  return [object.stages];
}

void _cropInformationAttach(
    IsarCollection<dynamic> col, Id id, CropInformation object) {
  object.cropID = id;
  object.stages.attach(col, col.isar.collection<Stages>(), r'stages', id);
}

extension CropInformationQueryWhereSort
    on QueryBuilder<CropInformation, CropInformation, QWhere> {
  QueryBuilder<CropInformation, CropInformation, QAfterWhere> anyCropID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CropInformationQueryWhere
    on QueryBuilder<CropInformation, CropInformation, QWhereClause> {
  QueryBuilder<CropInformation, CropInformation, QAfterWhereClause>
      cropIDEqualTo(Id cropID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: cropID,
        upper: cropID,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterWhereClause>
      cropIDNotEqualTo(Id cropID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: cropID, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: cropID, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: cropID, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: cropID, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterWhereClause>
      cropIDGreaterThan(Id cropID, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: cropID, includeLower: include),
      );
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterWhereClause>
      cropIDLessThan(Id cropID, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: cropID, includeUpper: include),
      );
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterWhereClause>
      cropIDBetween(
    Id lowerCropID,
    Id upperCropID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerCropID,
        includeLower: includeLower,
        upper: upperCropID,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CropInformationQueryFilter
    on QueryBuilder<CropInformation, CropInformation, QFilterCondition> {
  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cropDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cropDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cropDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cropDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cropDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cropDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cropDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cropDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cropDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cropDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropIDEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cropID',
        value: value,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropIDGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cropID',
        value: value,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropIDLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cropID',
        value: value,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropIDBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cropID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cropName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cropName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cropName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cropName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cropName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cropName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cropName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cropName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cropName',
        value: '',
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      cropNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cropName',
        value: '',
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pictureDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pictureDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pictureDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pictureDir',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pictureDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pictureDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pictureDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pictureDir',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pictureDir',
        value: '',
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      pictureDirIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pictureDir',
        value: '',
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'soilType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilType',
        value: '',
      ));
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      soilTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'soilType',
        value: '',
      ));
    });
  }
}

extension CropInformationQueryObject
    on QueryBuilder<CropInformation, CropInformation, QFilterCondition> {}

extension CropInformationQueryLinks
    on QueryBuilder<CropInformation, CropInformation, QFilterCondition> {
  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition> stages(
      FilterQuery<Stages> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stages');
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      stagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', length, true, length, true);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      stagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', 0, true, 0, true);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      stagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', 0, false, 999999, true);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      stagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', 0, true, length, include);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      stagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', length, include, 999999, true);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterFilterCondition>
      stagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stages', lower, includeLower, upper, includeUpper);
    });
  }
}

extension CropInformationQuerySortBy
    on QueryBuilder<CropInformation, CropInformation, QSortBy> {
  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortByCropDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropDescription', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortByCropDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropDescription', Sort.desc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortByCropName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortByCropNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.desc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortByPictureDir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pictureDir', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortByPictureDirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pictureDir', Sort.desc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortBySoilType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      sortBySoilTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.desc);
    });
  }
}

extension CropInformationQuerySortThenBy
    on QueryBuilder<CropInformation, CropInformation, QSortThenBy> {
  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenByCropDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropDescription', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenByCropDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropDescription', Sort.desc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy> thenByCropID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropID', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenByCropIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropID', Sort.desc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenByCropName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenByCropNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.desc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenByPictureDir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pictureDir', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenByPictureDirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pictureDir', Sort.desc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenBySoilType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.asc);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QAfterSortBy>
      thenBySoilTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.desc);
    });
  }
}

extension CropInformationQueryWhereDistinct
    on QueryBuilder<CropInformation, CropInformation, QDistinct> {
  QueryBuilder<CropInformation, CropInformation, QDistinct>
      distinctByCropDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cropDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QDistinct> distinctByCropName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cropName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QDistinct>
      distinctByPictureDir({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pictureDir', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CropInformation, CropInformation, QDistinct> distinctBySoilType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilType', caseSensitive: caseSensitive);
    });
  }
}

extension CropInformationQueryProperty
    on QueryBuilder<CropInformation, CropInformation, QQueryProperty> {
  QueryBuilder<CropInformation, int, QQueryOperations> cropIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cropID');
    });
  }

  QueryBuilder<CropInformation, String, QQueryOperations>
      cropDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cropDescription');
    });
  }

  QueryBuilder<CropInformation, String, QQueryOperations> cropNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cropName');
    });
  }

  QueryBuilder<CropInformation, String, QQueryOperations> pictureDirProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pictureDir');
    });
  }

  QueryBuilder<CropInformation, String, QQueryOperations> soilTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilType');
    });
  }
}