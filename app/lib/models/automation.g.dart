// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAutomationCollection on Isar {
  IsarCollection<Automation> get automations => this.collection();
}

const AutomationSchema = CollectionSchema(
  name: r'Automation',
  id: -1568414417195901326,
  properties: {
    r'commands': PropertySchema(
      id: 0,
      name: r'commands',
      type: IsarType.objectList,
      target: r'Command',
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _automationEstimateSize,
  serialize: _automationSerialize,
  deserialize: _automationDeserialize,
  deserializeProp: _automationDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Command': CommandSchema,
    r'Operation': OperationSchema,
    r'Argument': ArgumentSchema
  },
  getId: _automationGetId,
  getLinks: _automationGetLinks,
  attach: _automationAttach,
  version: '3.1.0+1',
);

int _automationEstimateSize(
  Automation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.commands.length * 3;
  {
    final offsets = allOffsets[Command]!;
    for (var i = 0; i < object.commands.length; i++) {
      final value = object.commands[i];
      bytesCount += CommandSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _automationSerialize(
  Automation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Command>(
    offsets[0],
    allOffsets,
    CommandSchema.serialize,
    object.commands,
  );
  writer.writeString(offsets[1], object.name);
}

Automation _automationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Automation();
  object.commands = reader.readObjectList<Command>(
        offsets[0],
        CommandSchema.deserialize,
        allOffsets,
        Command(),
      ) ??
      [];
  object.id = id;
  object.name = reader.readString(offsets[1]);
  return object;
}

P _automationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Command>(
            offset,
            CommandSchema.deserialize,
            allOffsets,
            Command(),
          ) ??
          []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _automationGetId(Automation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _automationGetLinks(Automation object) {
  return [];
}

void _automationAttach(IsarCollection<dynamic> col, Id id, Automation object) {
  object.id = id;
}

extension AutomationQueryWhereSort
    on QueryBuilder<Automation, Automation, QWhere> {
  QueryBuilder<Automation, Automation, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AutomationQueryWhere
    on QueryBuilder<Automation, Automation, QWhereClause> {
  QueryBuilder<Automation, Automation, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Automation, Automation, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Automation, Automation, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterWhereClause> idBetween(
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

extension AutomationQueryFilter
    on QueryBuilder<Automation, Automation, QFilterCondition> {
  QueryBuilder<Automation, Automation, QAfterFilterCondition>
      commandsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition>
      commandsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition>
      commandsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition>
      commandsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition>
      commandsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition>
      commandsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Automation, Automation, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension AutomationQueryObject
    on QueryBuilder<Automation, Automation, QFilterCondition> {
  QueryBuilder<Automation, Automation, QAfterFilterCondition> commandsElement(
      FilterQuery<Command> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'commands');
    });
  }
}

extension AutomationQueryLinks
    on QueryBuilder<Automation, Automation, QFilterCondition> {}

extension AutomationQuerySortBy
    on QueryBuilder<Automation, Automation, QSortBy> {
  QueryBuilder<Automation, Automation, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Automation, Automation, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension AutomationQuerySortThenBy
    on QueryBuilder<Automation, Automation, QSortThenBy> {
  QueryBuilder<Automation, Automation, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Automation, Automation, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Automation, Automation, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Automation, Automation, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension AutomationQueryWhereDistinct
    on QueryBuilder<Automation, Automation, QDistinct> {
  QueryBuilder<Automation, Automation, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension AutomationQueryProperty
    on QueryBuilder<Automation, Automation, QQueryProperty> {
  QueryBuilder<Automation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Automation, List<Command>, QQueryOperations> commandsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commands');
    });
  }

  QueryBuilder<Automation, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CommandSchema = Schema(
  name: r'Command',
  id: -7843876013807952187,
  properties: {
    r'operation': PropertySchema(
      id: 0,
      name: r'operation',
      type: IsarType.object,
      target: r'Operation',
    ),
    r'type': PropertySchema(
      id: 1,
      name: r'type',
      type: IsarType.string,
      enumMap: _CommandtypeEnumValueMap,
    )
  },
  estimateSize: _commandEstimateSize,
  serialize: _commandSerialize,
  deserialize: _commandDeserialize,
  deserializeProp: _commandDeserializeProp,
);

int _commandEstimateSize(
  Command object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      OperationSchema.estimateSize(
          object.operation, allOffsets[Operation]!, allOffsets);
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _commandSerialize(
  Command object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<Operation>(
    offsets[0],
    allOffsets,
    OperationSchema.serialize,
    object.operation,
  );
  writer.writeString(offsets[1], object.type.name);
}

Command _commandDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Command();
  object.operation = reader.readObjectOrNull<Operation>(
        offsets[0],
        OperationSchema.deserialize,
        allOffsets,
      ) ??
      Operation();
  object.type = _CommandtypeValueEnumMap[reader.readStringOrNull(offsets[1])] ??
      CommandType.adb;
  return object;
}

P _commandDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<Operation>(
            offset,
            OperationSchema.deserialize,
            allOffsets,
          ) ??
          Operation()) as P;
    case 1:
      return (_CommandtypeValueEnumMap[reader.readStringOrNull(offset)] ??
          CommandType.adb) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CommandtypeEnumValueMap = {
  r'adb': r'adb',
};
const _CommandtypeValueEnumMap = {
  r'adb': CommandType.adb,
};

extension CommandQueryFilter
    on QueryBuilder<Command, Command, QFilterCondition> {
  QueryBuilder<Command, Command, QAfterFilterCondition> typeEqualTo(
    CommandType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeGreaterThan(
    CommandType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeLessThan(
    CommandType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeBetween(
    CommandType lower,
    CommandType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Command, Command, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension CommandQueryObject
    on QueryBuilder<Command, Command, QFilterCondition> {
  QueryBuilder<Command, Command, QAfterFilterCondition> operation(
      FilterQuery<Operation> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'operation');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const OperationSchema = Schema(
  name: r'Operation',
  id: -4996007378082647893,
  properties: {
    r'arguments': PropertySchema(
      id: 0,
      name: r'arguments',
      type: IsarType.objectList,
      target: r'Argument',
    ),
    r'type': PropertySchema(
      id: 1,
      name: r'type',
      type: IsarType.string,
      enumMap: _OperationtypeEnumValueMap,
    )
  },
  estimateSize: _operationEstimateSize,
  serialize: _operationSerialize,
  deserialize: _operationDeserialize,
  deserializeProp: _operationDeserializeProp,
);

int _operationEstimateSize(
  Operation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.arguments.length * 3;
  {
    final offsets = allOffsets[Argument]!;
    for (var i = 0; i < object.arguments.length; i++) {
      final value = object.arguments[i];
      bytesCount += ArgumentSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _operationSerialize(
  Operation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Argument>(
    offsets[0],
    allOffsets,
    ArgumentSchema.serialize,
    object.arguments,
  );
  writer.writeString(offsets[1], object.type.name);
}

Operation _operationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Operation();
  object.arguments = reader.readObjectList<Argument>(
        offsets[0],
        ArgumentSchema.deserialize,
        allOffsets,
        Argument(),
      ) ??
      [];
  object.type =
      _OperationtypeValueEnumMap[reader.readStringOrNull(offsets[1])] ??
          OperationType.keyboardInput;
  return object;
}

P _operationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Argument>(
            offset,
            ArgumentSchema.deserialize,
            allOffsets,
            Argument(),
          ) ??
          []) as P;
    case 1:
      return (_OperationtypeValueEnumMap[reader.readStringOrNull(offset)] ??
          OperationType.keyboardInput) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _OperationtypeEnumValueMap = {
  r'keyboardInput': r'keyboardInput',
  r'keyCode': r'keyCode',
  r'reboot': r'reboot',
};
const _OperationtypeValueEnumMap = {
  r'keyboardInput': OperationType.keyboardInput,
  r'keyCode': OperationType.keyCode,
  r'reboot': OperationType.reboot,
};

extension OperationQueryFilter
    on QueryBuilder<Operation, Operation, QFilterCondition> {
  QueryBuilder<Operation, Operation, QAfterFilterCondition>
      argumentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> argumentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition>
      argumentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition>
      argumentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition>
      argumentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition>
      argumentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'arguments',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeEqualTo(
    OperationType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeGreaterThan(
    OperationType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeLessThan(
    OperationType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeBetween(
    OperationType lower,
    OperationType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Operation, Operation, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension OperationQueryObject
    on QueryBuilder<Operation, Operation, QFilterCondition> {
  QueryBuilder<Operation, Operation, QAfterFilterCondition> argumentsElement(
      FilterQuery<Argument> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'arguments');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ArgumentSchema = Schema(
  name: r'Argument',
  id: -1337893213978328087,
  properties: {
    r'inputType': PropertySchema(
      id: 0,
      name: r'inputType',
      type: IsarType.string,
      enumMap: _ArgumentinputTypeEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 1,
      name: r'type',
      type: IsarType.string,
      enumMap: _ArgumenttypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 2,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _argumentEstimateSize,
  serialize: _argumentSerialize,
  deserialize: _argumentDeserialize,
  deserializeProp: _argumentDeserializeProp,
);

int _argumentEstimateSize(
  Argument object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.inputType.name.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _argumentSerialize(
  Argument object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.inputType.name);
  writer.writeString(offsets[1], object.type.name);
  writer.writeString(offsets[2], object.value);
}

Argument _argumentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Argument();
  object.inputType =
      _ArgumentinputTypeValueEnumMap[reader.readStringOrNull(offsets[0])] ??
          InputType.select;
  object.type =
      _ArgumenttypeValueEnumMap[reader.readStringOrNull(offsets[1])] ??
          ArgumentType.keyCode;
  object.value = reader.readString(offsets[2]);
  return object;
}

P _argumentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ArgumentinputTypeValueEnumMap[reader.readStringOrNull(offset)] ??
          InputType.select) as P;
    case 1:
      return (_ArgumenttypeValueEnumMap[reader.readStringOrNull(offset)] ??
          ArgumentType.keyCode) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ArgumentinputTypeEnumValueMap = {
  r'select': r'select',
  r'static': r'static',
  r'text': r'text',
};
const _ArgumentinputTypeValueEnumMap = {
  r'select': InputType.select,
  r'static': InputType.static,
  r'text': InputType.text,
};
const _ArgumenttypeEnumValueMap = {
  r'keyCode': r'keyCode',
  r'static': r'static',
  r'text': r'text',
};
const _ArgumenttypeValueEnumMap = {
  r'keyCode': ArgumentType.keyCode,
  r'static': ArgumentType.static,
  r'text': ArgumentType.text,
};

extension ArgumentQueryFilter
    on QueryBuilder<Argument, Argument, QFilterCondition> {
  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeEqualTo(
    InputType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeGreaterThan(
    InputType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeLessThan(
    InputType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeBetween(
    InputType lower,
    InputType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inputType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inputType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inputType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inputType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> inputTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputType',
        value: '',
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition>
      inputTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inputType',
        value: '',
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeEqualTo(
    ArgumentType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeGreaterThan(
    ArgumentType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeLessThan(
    ArgumentType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeBetween(
    ArgumentType lower,
    ArgumentType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<Argument, Argument, QAfterFilterCondition> valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension ArgumentQueryObject
    on QueryBuilder<Argument, Argument, QFilterCondition> {}
