// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emulator.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmulatorCollection on Isar {
  IsarCollection<Emulator> get emulators => this.collection();
}

const EmulatorSchema = CollectionSchema(
  name: r'Emulator',
  id: -5930111741697886505,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'params': PropertySchema(
      id: 1,
      name: r'params',
      type: IsarType.object,
      target: r'EmulatorParams',
    )
  },
  estimateSize: _emulatorEstimateSize,
  serialize: _emulatorSerialize,
  deserialize: _emulatorDeserialize,
  deserializeProp: _emulatorDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'EmulatorParams': EmulatorParamsSchema},
  getId: _emulatorGetId,
  getLinks: _emulatorGetLinks,
  attach: _emulatorAttach,
  version: '3.1.0+1',
);

int _emulatorEstimateSize(
  Emulator object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 +
      EmulatorParamsSchema.estimateSize(
          object.params, allOffsets[EmulatorParams]!, allOffsets);
  return bytesCount;
}

void _emulatorSerialize(
  Emulator object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeObject<EmulatorParams>(
    offsets[1],
    allOffsets,
    EmulatorParamsSchema.serialize,
    object.params,
  );
}

Emulator _emulatorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Emulator();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  object.params = reader.readObjectOrNull<EmulatorParams>(
        offsets[1],
        EmulatorParamsSchema.deserialize,
        allOffsets,
      ) ??
      EmulatorParams();
  return object;
}

P _emulatorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<EmulatorParams>(
            offset,
            EmulatorParamsSchema.deserialize,
            allOffsets,
          ) ??
          EmulatorParams()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _emulatorGetId(Emulator object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _emulatorGetLinks(Emulator object) {
  return [];
}

void _emulatorAttach(IsarCollection<dynamic> col, Id id, Emulator object) {
  object.id = id;
}

extension EmulatorQueryWhereSort on QueryBuilder<Emulator, Emulator, QWhere> {
  QueryBuilder<Emulator, Emulator, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmulatorQueryWhere on QueryBuilder<Emulator, Emulator, QWhereClause> {
  QueryBuilder<Emulator, Emulator, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Emulator, Emulator, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterWhereClause> idBetween(
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

extension EmulatorQueryFilter
    on QueryBuilder<Emulator, Emulator, QFilterCondition> {
  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension EmulatorQueryObject
    on QueryBuilder<Emulator, Emulator, QFilterCondition> {
  QueryBuilder<Emulator, Emulator, QAfterFilterCondition> params(
      FilterQuery<EmulatorParams> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'params');
    });
  }
}

extension EmulatorQueryLinks
    on QueryBuilder<Emulator, Emulator, QFilterCondition> {}

extension EmulatorQuerySortBy on QueryBuilder<Emulator, Emulator, QSortBy> {
  QueryBuilder<Emulator, Emulator, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension EmulatorQuerySortThenBy
    on QueryBuilder<Emulator, Emulator, QSortThenBy> {
  QueryBuilder<Emulator, Emulator, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Emulator, Emulator, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension EmulatorQueryWhereDistinct
    on QueryBuilder<Emulator, Emulator, QDistinct> {
  QueryBuilder<Emulator, Emulator, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension EmulatorQueryProperty
    on QueryBuilder<Emulator, Emulator, QQueryProperty> {
  QueryBuilder<Emulator, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Emulator, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Emulator, EmulatorParams, QQueryOperations> paramsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'params');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EmulatorParamsSchema = Schema(
  name: r'EmulatorParams',
  id: 6115662269943298065,
  properties: {
    r'noSnapshotLoad': PropertySchema(
      id: 0,
      name: r'noSnapshotLoad',
      type: IsarType.bool,
    ),
    r'writeableSystem': PropertySchema(
      id: 1,
      name: r'writeableSystem',
      type: IsarType.bool,
    )
  },
  estimateSize: _emulatorParamsEstimateSize,
  serialize: _emulatorParamsSerialize,
  deserialize: _emulatorParamsDeserialize,
  deserializeProp: _emulatorParamsDeserializeProp,
);

int _emulatorParamsEstimateSize(
  EmulatorParams object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _emulatorParamsSerialize(
  EmulatorParams object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.noSnapshotLoad);
  writer.writeBool(offsets[1], object.writeableSystem);
}

EmulatorParams _emulatorParamsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmulatorParams();
  object.noSnapshotLoad = reader.readBool(offsets[0]);
  object.writeableSystem = reader.readBool(offsets[1]);
  return object;
}

P _emulatorParamsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EmulatorParamsQueryFilter
    on QueryBuilder<EmulatorParams, EmulatorParams, QFilterCondition> {
  QueryBuilder<EmulatorParams, EmulatorParams, QAfterFilterCondition>
      noSnapshotLoadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noSnapshotLoad',
        value: value,
      ));
    });
  }

  QueryBuilder<EmulatorParams, EmulatorParams, QAfterFilterCondition>
      writeableSystemEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'writeableSystem',
        value: value,
      ));
    });
  }
}

extension EmulatorParamsQueryObject
    on QueryBuilder<EmulatorParams, EmulatorParams, QFilterCondition> {}
