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
    r'commandType': PropertySchema(
      id: 0,
      name: r'commandType',
      type: IsarType.string,
    ),
    r'nodeNum': PropertySchema(
      id: 1,
      name: r'nodeNum',
      type: IsarType.long,
    ),
    r'scheduleID': PropertySchema(
      id: 2,
      name: r'scheduleID',
      type: IsarType.long,
    ),
    r'timeDate': PropertySchema(
      id: 3,
      name: r'timeDate',
      type: IsarType.dateTime,
    ),
    r'waterAmount': PropertySchema(
      id: 4,
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
  bytesCount += 3 + object.commandType.length * 3;
  return bytesCount;
}

void _scheduleSerialize(
  Schedule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.commandType);
  writer.writeLong(offsets[1], object.nodeNum);
  writer.writeLong(offsets[2], object.scheduleID);
  writer.writeDateTime(offsets[3], object.timeDate);
  writer.writeLong(offsets[4], object.waterAmount);
}

Schedule _scheduleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Schedule();
  object.commandType = reader.readString(offsets[0]);
  object.id = id;
  object.nodeNum = reader.readLong(offsets[1]);
  object.scheduleID = reader.readLong(offsets[2]);
  object.timeDate = reader.readDateTime(offsets[3]);
  object.waterAmount = reader.readLong(offsets[4]);
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
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
  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition>
      commandTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commandType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commandType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> commandTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandType',
        value: '',
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition>
      commandTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commandType',
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

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> scheduleIDEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleID',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> scheduleIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduleID',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> scheduleIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduleID',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> scheduleIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduleID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterFilterCondition> timeDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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
  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByCommandType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByCommandTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.desc);
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

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByScheduleID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByScheduleIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByTimeDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> sortByTimeDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.desc);
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
  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByCommandType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByCommandTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.desc);
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

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByScheduleID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByScheduleIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.desc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByTimeDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.asc);
    });
  }

  QueryBuilder<Schedule, Schedule, QAfterSortBy> thenByTimeDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.desc);
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
  QueryBuilder<Schedule, Schedule, QDistinct> distinctByCommandType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commandType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Schedule, Schedule, QDistinct> distinctByNodeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nodeNum');
    });
  }

  QueryBuilder<Schedule, Schedule, QDistinct> distinctByScheduleID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleID');
    });
  }

  QueryBuilder<Schedule, Schedule, QDistinct> distinctByTimeDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeDate');
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

  QueryBuilder<Schedule, String, QQueryOperations> commandTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commandType');
    });
  }

  QueryBuilder<Schedule, int, QQueryOperations> nodeNumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodeNum');
    });
  }

  QueryBuilder<Schedule, int, QQueryOperations> scheduleIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleID');
    });
  }

  QueryBuilder<Schedule, DateTime, QQueryOperations> timeDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeDate');
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

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNodesCollection on Isar {
  IsarCollection<Nodes> get nodes => this.collection();
}

const NodesSchema = CollectionSchema(
  name: r'Nodes',
  id: 5996734671730882318,
  properties: {
    r'nodeNumber': PropertySchema(
      id: 0,
      name: r'nodeNumber',
      type: IsarType.long,
    ),
    r'plant': PropertySchema(
      id: 1,
      name: r'plant',
      type: IsarType.string,
    ),
    r'soilType': PropertySchema(
      id: 2,
      name: r'soilType',
      type: IsarType.string,
    ),
    r'waterPerDay': PropertySchema(
      id: 3,
      name: r'waterPerDay',
      type: IsarType.longList,
    )
  },
  estimateSize: _nodesEstimateSize,
  serialize: _nodesSerialize,
  deserialize: _nodesDeserialize,
  deserializeProp: _nodesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _nodesGetId,
  getLinks: _nodesGetLinks,
  attach: _nodesAttach,
  version: '3.1.0+1',
);

int _nodesEstimateSize(
  Nodes object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.plant.length * 3;
  bytesCount += 3 + object.soilType.length * 3;
  bytesCount += 3 + object.waterPerDay.length * 8;
  return bytesCount;
}

void _nodesSerialize(
  Nodes object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.nodeNumber);
  writer.writeString(offsets[1], object.plant);
  writer.writeString(offsets[2], object.soilType);
  writer.writeLongList(offsets[3], object.waterPerDay);
}

Nodes _nodesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Nodes();
  object.id = id;
  object.nodeNumber = reader.readLong(offsets[0]);
  object.plant = reader.readString(offsets[1]);
  object.soilType = reader.readString(offsets[2]);
  object.waterPerDay = reader.readLongList(offsets[3]) ?? [];
  return object;
}

P _nodesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _nodesGetId(Nodes object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _nodesGetLinks(Nodes object) {
  return [];
}

void _nodesAttach(IsarCollection<dynamic> col, Id id, Nodes object) {
  object.id = id;
}

extension NodesQueryWhereSort on QueryBuilder<Nodes, Nodes, QWhere> {
  QueryBuilder<Nodes, Nodes, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NodesQueryWhere on QueryBuilder<Nodes, Nodes, QWhereClause> {
  QueryBuilder<Nodes, Nodes, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Nodes, Nodes, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterWhereClause> idBetween(
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

extension NodesQueryFilter on QueryBuilder<Nodes, Nodes, QFilterCondition> {
  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> nodeNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> nodeNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nodeNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> nodeNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nodeNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> nodeNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nodeNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plant',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plant',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plant',
        value: '',
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> plantIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plant',
        value: '',
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeEqualTo(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeGreaterThan(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeLessThan(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeBetween(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeStartsWith(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeEndsWith(
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

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'soilType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilType',
        value: '',
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> soilTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'soilType',
        value: '',
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition>
      waterPerDayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterPerDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterPerDay',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterPerDay',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterPerDay',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterPerDay',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition>
      waterPerDayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterPerDay',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterFilterCondition> waterPerDayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterPerDay',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension NodesQueryObject on QueryBuilder<Nodes, Nodes, QFilterCondition> {}

extension NodesQueryLinks on QueryBuilder<Nodes, Nodes, QFilterCondition> {}

extension NodesQuerySortBy on QueryBuilder<Nodes, Nodes, QSortBy> {
  QueryBuilder<Nodes, Nodes, QAfterSortBy> sortByNodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNumber', Sort.asc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> sortByNodeNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNumber', Sort.desc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> sortByPlant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.asc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> sortByPlantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.desc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> sortBySoilType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.asc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> sortBySoilTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.desc);
    });
  }
}

extension NodesQuerySortThenBy on QueryBuilder<Nodes, Nodes, QSortThenBy> {
  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenByNodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNumber', Sort.asc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenByNodeNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNumber', Sort.desc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenByPlant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.asc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenByPlantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.desc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenBySoilType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.asc);
    });
  }

  QueryBuilder<Nodes, Nodes, QAfterSortBy> thenBySoilTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.desc);
    });
  }
}

extension NodesQueryWhereDistinct on QueryBuilder<Nodes, Nodes, QDistinct> {
  QueryBuilder<Nodes, Nodes, QDistinct> distinctByNodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nodeNumber');
    });
  }

  QueryBuilder<Nodes, Nodes, QDistinct> distinctByPlant(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plant', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Nodes, Nodes, QDistinct> distinctBySoilType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Nodes, Nodes, QDistinct> distinctByWaterPerDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterPerDay');
    });
  }
}

extension NodesQueryProperty on QueryBuilder<Nodes, Nodes, QQueryProperty> {
  QueryBuilder<Nodes, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Nodes, int, QQueryOperations> nodeNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodeNumber');
    });
  }

  QueryBuilder<Nodes, String, QQueryOperations> plantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plant');
    });
  }

  QueryBuilder<Nodes, String, QQueryOperations> soilTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilType');
    });
  }

  QueryBuilder<Nodes, List<int>, QQueryOperations> waterPerDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterPerDay');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAutoScheduleCollection on Isar {
  IsarCollection<AutoSchedule> get autoSchedules => this.collection();
}

const AutoScheduleSchema = CollectionSchema(
  name: r'AutoSchedule',
  id: -8876412207724508316,
  properties: {
    r'commandType': PropertySchema(
      id: 0,
      name: r'commandType',
      type: IsarType.string,
    ),
    r'cropName': PropertySchema(
      id: 1,
      name: r'cropName',
      type: IsarType.string,
    ),
    r'day': PropertySchema(
      id: 2,
      name: r'day',
      type: IsarType.long,
    ),
    r'nodeNum': PropertySchema(
      id: 3,
      name: r'nodeNum',
      type: IsarType.long,
    ),
    r'scheduleID': PropertySchema(
      id: 4,
      name: r'scheduleID',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
    ),
    r'timeDate': PropertySchema(
      id: 6,
      name: r'timeDate',
      type: IsarType.dateTime,
    ),
    r'waterAmount': PropertySchema(
      id: 7,
      name: r'waterAmount',
      type: IsarType.long,
    ),
    r'week': PropertySchema(
      id: 8,
      name: r'week',
      type: IsarType.long,
    )
  },
  estimateSize: _autoScheduleEstimateSize,
  serialize: _autoScheduleSerialize,
  deserialize: _autoScheduleDeserialize,
  deserializeProp: _autoScheduleDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _autoScheduleGetId,
  getLinks: _autoScheduleGetLinks,
  attach: _autoScheduleAttach,
  version: '3.1.0+1',
);

int _autoScheduleEstimateSize(
  AutoSchedule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.commandType.length * 3;
  bytesCount += 3 + object.cropName.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _autoScheduleSerialize(
  AutoSchedule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.commandType);
  writer.writeString(offsets[1], object.cropName);
  writer.writeLong(offsets[2], object.day);
  writer.writeLong(offsets[3], object.nodeNum);
  writer.writeLong(offsets[4], object.scheduleID);
  writer.writeString(offsets[5], object.status);
  writer.writeDateTime(offsets[6], object.timeDate);
  writer.writeLong(offsets[7], object.waterAmount);
  writer.writeLong(offsets[8], object.week);
}

AutoSchedule _autoScheduleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AutoSchedule();
  object.commandType = reader.readString(offsets[0]);
  object.cropName = reader.readString(offsets[1]);
  object.day = reader.readLong(offsets[2]);
  object.id = id;
  object.nodeNum = reader.readLong(offsets[3]);
  object.scheduleID = reader.readLong(offsets[4]);
  object.status = reader.readString(offsets[5]);
  object.timeDate = reader.readDateTime(offsets[6]);
  object.waterAmount = reader.readLong(offsets[7]);
  object.week = reader.readLong(offsets[8]);
  return object;
}

P _autoScheduleDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _autoScheduleGetId(AutoSchedule object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _autoScheduleGetLinks(AutoSchedule object) {
  return [];
}

void _autoScheduleAttach(
    IsarCollection<dynamic> col, Id id, AutoSchedule object) {
  object.id = id;
}

extension AutoScheduleQueryWhereSort
    on QueryBuilder<AutoSchedule, AutoSchedule, QWhere> {
  QueryBuilder<AutoSchedule, AutoSchedule, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AutoScheduleQueryWhere
    on QueryBuilder<AutoSchedule, AutoSchedule, QWhereClause> {
  QueryBuilder<AutoSchedule, AutoSchedule, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterWhereClause> idBetween(
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

extension AutoScheduleQueryFilter
    on QueryBuilder<AutoSchedule, AutoSchedule, QFilterCondition> {
  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commandType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commandType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commandType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandType',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      commandTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commandType',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      cropNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cropName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      cropNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cropName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      cropNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cropName',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      cropNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cropName',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> dayEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      dayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> dayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> dayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'day',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      nodeNumEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeNum',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      nodeNumGreaterThan(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      nodeNumLessThan(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      nodeNumBetween(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      scheduleIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleID',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      scheduleIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduleID',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      scheduleIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduleID',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      scheduleIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduleID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      timeDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      timeDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      timeDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      timeDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      waterAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      waterAmountLessThan(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      waterAmountBetween(
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

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> weekEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'week',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition>
      weekGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'week',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> weekLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'week',
        value: value,
      ));
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterFilterCondition> weekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'week',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AutoScheduleQueryObject
    on QueryBuilder<AutoSchedule, AutoSchedule, QFilterCondition> {}

extension AutoScheduleQueryLinks
    on QueryBuilder<AutoSchedule, AutoSchedule, QFilterCondition> {}

extension AutoScheduleQuerySortBy
    on QueryBuilder<AutoSchedule, AutoSchedule, QSortBy> {
  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByCommandType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy>
      sortByCommandTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByCropName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByCropNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByNodeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByNodeNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByScheduleID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy>
      sortByScheduleIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByTimeDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByTimeDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy>
      sortByWaterAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> sortByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }
}

extension AutoScheduleQuerySortThenBy
    on QueryBuilder<AutoSchedule, AutoSchedule, QSortThenBy> {
  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByCommandType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy>
      thenByCommandTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commandType', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByCropName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByCropNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cropName', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByNodeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByNodeNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeNum', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByScheduleID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy>
      thenByScheduleIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleID', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByTimeDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByTimeDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeDate', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy>
      thenByWaterAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterAmount', Sort.desc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.asc);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QAfterSortBy> thenByWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'week', Sort.desc);
    });
  }
}

extension AutoScheduleQueryWhereDistinct
    on QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> {
  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByCommandType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commandType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByCropName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cropName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'day');
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByNodeNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nodeNum');
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByScheduleID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleID');
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByTimeDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeDate');
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByWaterAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterAmount');
    });
  }

  QueryBuilder<AutoSchedule, AutoSchedule, QDistinct> distinctByWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'week');
    });
  }
}

extension AutoScheduleQueryProperty
    on QueryBuilder<AutoSchedule, AutoSchedule, QQueryProperty> {
  QueryBuilder<AutoSchedule, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AutoSchedule, String, QQueryOperations> commandTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commandType');
    });
  }

  QueryBuilder<AutoSchedule, String, QQueryOperations> cropNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cropName');
    });
  }

  QueryBuilder<AutoSchedule, int, QQueryOperations> dayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'day');
    });
  }

  QueryBuilder<AutoSchedule, int, QQueryOperations> nodeNumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodeNum');
    });
  }

  QueryBuilder<AutoSchedule, int, QQueryOperations> scheduleIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleID');
    });
  }

  QueryBuilder<AutoSchedule, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<AutoSchedule, DateTime, QQueryOperations> timeDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeDate');
    });
  }

  QueryBuilder<AutoSchedule, int, QQueryOperations> waterAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterAmount');
    });
  }

  QueryBuilder<AutoSchedule, int, QQueryOperations> weekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'week');
    });
  }
}
