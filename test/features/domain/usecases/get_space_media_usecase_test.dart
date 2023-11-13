import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/usecase.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/usecases/get_space_media_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaUsecase(repository);
  });

  final tSpaceMedia = SpaceMediaEntity(
      description: 'description',
      mediaType: 'mediaType',
      title: 'title',
      mediaUrl: 'mediaUrl');
  final tNoParams = NoParams();

  test('shold get space media entity from for a given date from the repository',
      () {
    when(repository.getSpaceMediaFromDate)
        .thenAnswer((_) => Right(tSpaceMedia));
    final result = usecase(tNoParams);
    expect(result, Right(tSpaceMedia));
    verify(repository);
  });
}
