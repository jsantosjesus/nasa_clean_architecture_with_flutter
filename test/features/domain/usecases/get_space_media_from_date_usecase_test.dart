import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
// import 'package:nasa_clean_architecture_with_flutter/core/usecase/usecase.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  final tDate = DateTime(2023, 11, 13);

  test('shold get space media entity from for a given date from the repository',
      () async {
    when(() => repository.getSpaceMediaFromDate(any())).thenAnswer(
        (_) async => Right<Failure, SpaceMediaEntity>(tSpaceMediaEntity));
    // Act
    final result = await usecase(tDate);
    // Assert
    expect(result, Right(tSpaceMediaEntity));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('should return a ServerFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(any())).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));
    // Act
    final result = await usecase(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('should return a NullParamFailure when receives null params', () async {
    // Arrange
    // Act
    final result = await usecase(null);
    // Assert
    expect(result, Left(NullParamFailure()));
    verifyNever(() => repository.getSpaceMediaFromDate(tDate));
  });
}
