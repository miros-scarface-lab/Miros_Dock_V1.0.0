// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServerConfigCollection on Isar {
  IsarCollection<ServerConfig> get serverConfigs => this.collection();
}

const ServerConfigSchema = CollectionSchema(
  name: r'ServerConfig',
  id: 1008593162716439537,
  properties: {
    r'adminPasswordHash': PropertySchema(
      id: 0,
      name: r'adminPasswordHash',
      type: IsarType.string,
    ),
    r'adminUsername': PropertySchema(
      id: 1,
      name: r'adminUsername',
      type: IsarType.string,
    ),
    r'authenticationEnabled': PropertySchema(
      id: 2,
      name: r'authenticationEnabled',
      type: IsarType.bool,
    ),
    r'autoStart': PropertySchema(
      id: 3,
      name: r'autoStart',
      type: IsarType.bool,
    ),
    r'bandwidthLimit': PropertySchema(
      id: 4,
      name: r'bandwidthLimit',
      type: IsarType.long,
    ),
    r'deleteEnabled': PropertySchema(
      id: 5,
      name: r'deleteEnabled',
      type: IsarType.bool,
    ),
    r'downloadEnabled': PropertySchema(
      id: 6,
      name: r'downloadEnabled',
      type: IsarType.bool,
    ),
    r'isDarkMode': PropertySchema(
      id: 7,
      name: r'isDarkMode',
      type: IsarType.bool,
    ),
    r'maxClients': PropertySchema(
      id: 8,
      name: r'maxClients',
      type: IsarType.long,
    ),
    r'port': PropertySchema(
      id: 9,
      name: r'port',
      type: IsarType.long,
    ),
    r'renameEnabled': PropertySchema(
      id: 10,
      name: r'renameEnabled',
      type: IsarType.bool,
    ),
    r'selectedInterface': PropertySchema(
      id: 11,
      name: r'selectedInterface',
      type: IsarType.string,
    ),
    r'uploadEnabled': PropertySchema(
      id: 12,
      name: r'uploadEnabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _serverConfigEstimateSize,
  serialize: _serverConfigSerialize,
  deserialize: _serverConfigDeserialize,
  deserializeProp: _serverConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _serverConfigGetId,
  getLinks: _serverConfigGetLinks,
  attach: _serverConfigAttach,
  version: '3.1.0+1',
);

int _serverConfigEstimateSize(
  ServerConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.adminPasswordHash.length * 3;
  bytesCount += 3 + object.adminUsername.length * 3;
  {
    final value = object.selectedInterface;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _serverConfigSerialize(
  ServerConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.adminPasswordHash);
  writer.writeString(offsets[1], object.adminUsername);
  writer.writeBool(offsets[2], object.authenticationEnabled);
  writer.writeBool(offsets[3], object.autoStart);
  writer.writeLong(offsets[4], object.bandwidthLimit);
  writer.writeBool(offsets[5], object.deleteEnabled);
  writer.writeBool(offsets[6], object.downloadEnabled);
  writer.writeBool(offsets[7], object.isDarkMode);
  writer.writeLong(offsets[8], object.maxClients);
  writer.writeLong(offsets[9], object.port);
  writer.writeBool(offsets[10], object.renameEnabled);
  writer.writeString(offsets[11], object.selectedInterface);
  writer.writeBool(offsets[12], object.uploadEnabled);
}

ServerConfig _serverConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServerConfig();
  object.adminPasswordHash = reader.readString(offsets[0]);
  object.adminUsername = reader.readString(offsets[1]);
  object.authenticationEnabled = reader.readBool(offsets[2]);
  object.autoStart = reader.readBool(offsets[3]);
  object.bandwidthLimit = reader.readLongOrNull(offsets[4]);
  object.deleteEnabled = reader.readBool(offsets[5]);
  object.downloadEnabled = reader.readBool(offsets[6]);
  object.id = id;
  object.isDarkMode = reader.readBool(offsets[7]);
  object.maxClients = reader.readLong(offsets[8]);
  object.port = reader.readLong(offsets[9]);
  object.renameEnabled = reader.readBool(offsets[10]);
  object.selectedInterface = reader.readStringOrNull(offsets[11]);
  object.uploadEnabled = reader.readBool(offsets[12]);
  return object;
}

P _serverConfigDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _serverConfigGetId(ServerConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serverConfigGetLinks(ServerConfig object) {
  return [];
}

void _serverConfigAttach(
    IsarCollection<dynamic> col, Id id, ServerConfig object) {
  object.id = id;
}

extension ServerConfigQueryWhereSort
    on QueryBuilder<ServerConfig, ServerConfig, QWhere> {
  QueryBuilder<ServerConfig, ServerConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ServerConfigQueryWhere
    on QueryBuilder<ServerConfig, ServerConfig, QWhereClause> {
  QueryBuilder<ServerConfig, ServerConfig, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ServerConfig, ServerConfig, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterWhereClause> idBetween(
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

extension ServerConfigQueryFilter
    on QueryBuilder<ServerConfig, ServerConfig, QFilterCondition> {
  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminPasswordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adminPasswordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adminPasswordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adminPasswordHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'adminPasswordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'adminPasswordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminPasswordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminPasswordHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminPasswordHash',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminPasswordHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminPasswordHash',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adminUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adminUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adminUsername',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'adminUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'adminUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminUsername',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminUsername',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminUsername',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      adminUsernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminUsername',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      authenticationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authenticationEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      autoStartEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoStart',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      bandwidthLimitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bandwidthLimit',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      bandwidthLimitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bandwidthLimit',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      bandwidthLimitEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bandwidthLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      bandwidthLimitGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bandwidthLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      bandwidthLimitLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bandwidthLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      bandwidthLimitBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bandwidthLimit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      deleteEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleteEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      downloadEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      isDarkModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDarkMode',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      maxClientsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxClients',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      maxClientsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxClients',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      maxClientsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxClients',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      maxClientsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxClients',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition> portEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      portGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition> portLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition> portBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'port',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      renameEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'renameEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedInterface',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedInterface',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedInterface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedInterface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedInterface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedInterface',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selectedInterface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selectedInterface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selectedInterface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selectedInterface',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedInterface',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      selectedInterfaceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selectedInterface',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterFilterCondition>
      uploadEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uploadEnabled',
        value: value,
      ));
    });
  }
}

extension ServerConfigQueryObject
    on QueryBuilder<ServerConfig, ServerConfig, QFilterCondition> {}

extension ServerConfigQueryLinks
    on QueryBuilder<ServerConfig, ServerConfig, QFilterCondition> {}

extension ServerConfigQuerySortBy
    on QueryBuilder<ServerConfig, ServerConfig, QSortBy> {
  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByAdminPasswordHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminPasswordHash', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByAdminPasswordHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminPasswordHash', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByAdminUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminUsername', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByAdminUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminUsername', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByAuthenticationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByAuthenticationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByAutoStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStart', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByAutoStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStart', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByBandwidthLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bandwidthLimit', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByBandwidthLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bandwidthLimit', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByDeleteEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleteEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByDeleteEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleteEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByDownloadEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByDownloadEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByMaxClients() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxClients', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByMaxClientsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxClients', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByRenameEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renameEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByRenameEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renameEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortBySelectedInterface() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedInterface', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortBySelectedInterfaceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedInterface', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> sortByUploadEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      sortByUploadEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadEnabled', Sort.desc);
    });
  }
}

extension ServerConfigQuerySortThenBy
    on QueryBuilder<ServerConfig, ServerConfig, QSortThenBy> {
  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByAdminPasswordHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminPasswordHash', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByAdminPasswordHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminPasswordHash', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByAdminUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminUsername', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByAdminUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminUsername', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByAuthenticationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByAuthenticationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByAutoStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStart', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByAutoStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoStart', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByBandwidthLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bandwidthLimit', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByBandwidthLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bandwidthLimit', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByDeleteEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleteEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByDeleteEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleteEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByDownloadEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByDownloadEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByMaxClients() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxClients', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByMaxClientsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxClients', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByRenameEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renameEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByRenameEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renameEnabled', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenBySelectedInterface() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedInterface', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenBySelectedInterfaceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedInterface', Sort.desc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy> thenByUploadEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadEnabled', Sort.asc);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QAfterSortBy>
      thenByUploadEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadEnabled', Sort.desc);
    });
  }
}

extension ServerConfigQueryWhereDistinct
    on QueryBuilder<ServerConfig, ServerConfig, QDistinct> {
  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctByAdminPasswordHash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminPasswordHash',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct> distinctByAdminUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminUsername',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctByAuthenticationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authenticationEnabled');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct> distinctByAutoStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoStart');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctByBandwidthLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bandwidthLimit');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctByDeleteEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleteEnabled');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctByDownloadEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadEnabled');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct> distinctByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDarkMode');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct> distinctByMaxClients() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxClients');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct> distinctByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'port');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctByRenameEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'renameEnabled');
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctBySelectedInterface({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedInterface',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerConfig, ServerConfig, QDistinct>
      distinctByUploadEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uploadEnabled');
    });
  }
}

extension ServerConfigQueryProperty
    on QueryBuilder<ServerConfig, ServerConfig, QQueryProperty> {
  QueryBuilder<ServerConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ServerConfig, String, QQueryOperations>
      adminPasswordHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminPasswordHash');
    });
  }

  QueryBuilder<ServerConfig, String, QQueryOperations> adminUsernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminUsername');
    });
  }

  QueryBuilder<ServerConfig, bool, QQueryOperations>
      authenticationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authenticationEnabled');
    });
  }

  QueryBuilder<ServerConfig, bool, QQueryOperations> autoStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoStart');
    });
  }

  QueryBuilder<ServerConfig, int?, QQueryOperations> bandwidthLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bandwidthLimit');
    });
  }

  QueryBuilder<ServerConfig, bool, QQueryOperations> deleteEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleteEnabled');
    });
  }

  QueryBuilder<ServerConfig, bool, QQueryOperations> downloadEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadEnabled');
    });
  }

  QueryBuilder<ServerConfig, bool, QQueryOperations> isDarkModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDarkMode');
    });
  }

  QueryBuilder<ServerConfig, int, QQueryOperations> maxClientsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxClients');
    });
  }

  QueryBuilder<ServerConfig, int, QQueryOperations> portProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'port');
    });
  }

  QueryBuilder<ServerConfig, bool, QQueryOperations> renameEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'renameEnabled');
    });
  }

  QueryBuilder<ServerConfig, String?, QQueryOperations>
      selectedInterfaceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedInterface');
    });
  }

  QueryBuilder<ServerConfig, bool, QQueryOperations> uploadEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uploadEnabled');
    });
  }
}
