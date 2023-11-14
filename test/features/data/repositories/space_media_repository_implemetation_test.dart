import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/models/space_media_model.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/repositories/space_media_repository_implemetation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplemetation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplemetation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
      description: 'description',
      mediaType: 'mediaType',
      title: 'title',
      mediaUrl: 'mediaUrl');

  final tDate = DateTime(2023, 11, 13);

  test('shold return space media model when calls the datasource', () async {
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('shold return a server failure when calls to datasource is unsucessful',
      () async {
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
