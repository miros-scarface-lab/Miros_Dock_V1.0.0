// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_folder.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSharedFolderCollection on Isar {
  IsarCollection<SharedFolder> get sharedFolders => this.collection();
}

const SharedFolderSchema = CollectionSchema(
  name: r'SharedFolder',
  id: 6024752808500607104,
  properties: {
    r'addedAt': PropertySchema(
      id: 0,
      name: r'addedAt',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'physicalPath': PropertySchema(
      id: 2,
      name: r'physicalPath',
      type: IsarType.string,
    ),
    r'virtualPath': PropertySchema(
      id: 3,
      name: r'virtualPath',
      type: IsarType.string,
    )
  },
  estimateSize: _sharedFolderEstimateSize,
  serialize: _sharedFolderSerialize,
  deserialize: _sharedFolderDeserialize,
  deserializeProp: _sharedFolderDeserializeProp,
  idName: r'id',
  indexes: {
    r'physicalPath': IndexSchema(
      id: -1913275958561836485,
      name: r'physicalPath',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'physicalPath',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'virtualPath': IndexSchema(
      id: -3357044703392709690,
      name: r'virtualPath',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'virtualPath',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _sharedFolderGetId,
  getLinks: _sharedFolderGetLinks,
  attach: _sharedFolderAttach,
  version: '3.1.0+1',
);

int _sharedFolderEstimateSize(
  SharedFolder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.physicalPath.length * 3;
  bytesCount += 3 + object.virtualPath.length * 3;
  return bytesCount;
}

void _sharedFolderSerialize(
  SharedFolder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.addedAt);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.physicalPath);
  writer.writeString(offsets[3], object.virtualPath);
}

SharedFolder _sharedFolderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SharedFolder();
  object.addedAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  object.physicalPath = reader.readString(offsets[2]);
  object.virtualPath = reader.readString(offsets[3]);
  return object;
}

P _sharedFolderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
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

Id _sharedFolderGetId(SharedFolder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sharedFolderGetLinks(SharedFolder object) {
  return [];
}

void _sharedFolderAttach(
    IsarCollection<dynamic> col, Id id, SharedFolder object) {
  object.id = id;
}

extension SharedFolderByIndex on IsarCollection<SharedFolder> {
  Future<SharedFolder?> getByPhysicalPath(String physicalPath) {
    return getByIndex(r'physicalPath', [physicalPath]);
  }

  SharedFolder? getByPhysicalPathSync(String physicalPath) {
    return getByIndexSync(r'physicalPath', [physicalPath]);
  }

  Future<bool> deleteByPhysicalPath(String physicalPath) {
    return deleteByIndex(r'physicalPath', [physicalPath]);
  }

  bool deleteByPhysicalPathSync(String physicalPath) {
    return deleteByIndexSync(r'physicalPath', [physicalPath]);
  }

  Future<List<SharedFolder?>> getAllByPhysicalPath(
      List<String> physicalPathValues) {
    final values = physicalPathValues.map((e) => [e]).toList();
    return getAllByIndex(r'physicalPath', values);
  }

  List<SharedFolder?> getAllByPhysicalPathSync(
      List<String> physicalPathValues) {
    final values = physicalPathValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'physicalPath', values);
  }

  Future<int> deleteAllByPhysicalPath(List<String> physicalPathValues) {
    final values = physicalPathValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'physicalPath', values);
  }

  int deleteAllByPhysicalPathSync(List<String> physicalPathValues) {
    final values = physicalPathValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'physicalPath', values);
  }

  Future<Id> putByPhysicalPath(SharedFolder object) {
    return putByIndex(r'physicalPath', object);
  }

  Id putByPhysicalPathSync(SharedFolder object, {bool saveLinks = true}) {
    return putByIndexSync(r'physicalPath', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPhysicalPath(List<SharedFolder> objects) {
    return putAllByIndex(r'physicalPath', objects);
  }

  List<Id> putAllByPhysicalPathSync(List<SharedFolder> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'physicalPath', objects, saveLinks: saveLinks);
  }

  Future<SharedFolder?> getByVirtualPath(String virtualPath) {
    return getByIndex(r'virtualPath', [virtualPath]);
  }

  SharedFolder? getByVirtualPathSync(String virtualPath) {
    return getByIndexSync(r'virtualPath', [virtualPath]);
  }

  Future<bool> deleteByVirtualPath(String virtualPath) {
    return deleteByIndex(r'virtualPath', [virtualPath]);
  }

  bool deleteByVirtualPathSync(String virtualPath) {
    return deleteByIndexSync(r'virtualPath', [virtualPath]);
  }

  Future<List<SharedFolder?>> getAllByVirtualPath(
      List<String> virtualPathValues) {
    final values = virtualPathValues.map((e) => [e]).toList();
    return getAllByIndex(r'virtualPath', values);
  }

  List<SharedFolder?> getAllByVirtualPathSync(List<String> virtualPathValues) {
    final values = virtualPathValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'virtualPath', values);
  }

  Future<int> deleteAllByVirtualPath(List<String> virtualPathValues) {
    final values = virtualPathValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'virtualPath', values);
  }

  int deleteAllByVirtualPathSync(List<String> virtualPathValues) {
    final values = virtualPathValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'virtualPath', values);
  }

  Future<Id> putByVirtualPath(SharedFolder object) {
    return putByIndex(r'virtualPath', object);
  }

  Id putByVirtualPathSync(SharedFolder object, {bool saveLinks = true}) {
    return putByIndexSync(r'virtualPath', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByVirtualPath(List<SharedFolder> objects) {
    return putAllByIndex(r'virtualPath', objects);
  }

  List<Id> putAllByVirtualPathSync(List<SharedFolder> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'virtualPath', objects, saveLinks: saveLinks);
  }
}

extension SharedFolderQueryWhereSort
    on QueryBuilder<SharedFolder, SharedFolder, QWhere> {
  QueryBuilder<SharedFolder, SharedFolder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SharedFolderQueryWhere
    on QueryBuilder<SharedFolder, SharedFolder, QWhereClause> {
  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause> idBetween(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause>
      physicalPathEqualTo(String physicalPath) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'physicalPath',
        value: [physicalPath],
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause>
      physicalPathNotEqualTo(String physicalPath) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'physicalPath',
              lower: [],
              upper: [physicalPath],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'physicalPath',
              lower: [physicalPath],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'physicalPath',
              lower: [physicalPath],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'physicalPath',
              lower: [],
              upper: [physicalPath],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause>
      virtualPathEqualTo(String virtualPath) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'virtualPath',
        value: [virtualPath],
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterWhereClause>
      virtualPathNotEqualTo(String virtualPath) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'virtualPath',
              lower: [],
              upper: [virtualPath],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'virtualPath',
              lower: [virtualPath],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'virtualPath',
              lower: [virtualPath],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'virtualPath',
              lower: [],
              upper: [virtualPath],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SharedFolderQueryFilter
    on QueryBuilder<SharedFolder, SharedFolder, QFilterCondition> {
  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      addedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      addedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      addedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      addedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> nameContains(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'physicalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'physicalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'physicalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'physicalPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'physicalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'physicalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'physicalPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'physicalPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'physicalPath',
        value: '',
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      physicalPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'physicalPath',
        value: '',
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'virtualPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'virtualPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'virtualPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'virtualPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'virtualPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'virtualPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'virtualPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'virtualPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'virtualPath',
        value: '',
      ));
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterFilterCondition>
      virtualPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'virtualPath',
        value: '',
      ));
    });
  }
}

extension SharedFolderQueryObject
    on QueryBuilder<SharedFolder, SharedFolder, QFilterCondition> {}

extension SharedFolderQueryLinks
    on QueryBuilder<SharedFolder, SharedFolder, QFilterCondition> {}

extension SharedFolderQuerySortBy
    on QueryBuilder<SharedFolder, SharedFolder, QSortBy> {
  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> sortByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> sortByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> sortByPhysicalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalPath', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy>
      sortByPhysicalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalPath', Sort.desc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> sortByVirtualPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualPath', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy>
      sortByVirtualPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualPath', Sort.desc);
    });
  }
}

extension SharedFolderQuerySortThenBy
    on QueryBuilder<SharedFolder, SharedFolder, QSortThenBy> {
  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenByPhysicalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalPath', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy>
      thenByPhysicalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalPath', Sort.desc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy> thenByVirtualPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualPath', Sort.asc);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QAfterSortBy>
      thenByVirtualPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualPath', Sort.desc);
    });
  }
}

extension SharedFolderQueryWhereDistinct
    on QueryBuilder<SharedFolder, SharedFolder, QDistinct> {
  QueryBuilder<SharedFolder, SharedFolder, QDistinct> distinctByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedAt');
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QDistinct> distinctByPhysicalPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'physicalPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SharedFolder, SharedFolder, QDistinct> distinctByVirtualPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'virtualPath', caseSensitive: caseSensitive);
    });
  }
}

extension SharedFolderQueryProperty
    on QueryBuilder<SharedFolder, SharedFolder, QQueryProperty> {
  QueryBuilder<SharedFolder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SharedFolder, DateTime, QQueryOperations> addedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedAt');
    });
  }

  QueryBuilder<SharedFolder, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SharedFolder, String, QQueryOperations> physicalPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'physicalPath');
    });
  }

  QueryBuilder<SharedFolder, String, QQueryOperations> virtualPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'virtualPath');
    });
  }
}
