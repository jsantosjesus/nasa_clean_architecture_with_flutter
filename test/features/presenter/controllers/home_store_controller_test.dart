import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_architecture_with_flutter/features/presenter/controllers/home_store_controller.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';
import '../../../mocks/space_media_model_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeStoreController homeStoreController;
  late GetSpaceMediaFromDateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetSpaceMediaFromDateUsecase();
    homeStoreController = HomeStoreController(mockUsecase);
    registerFallbackValue(DateTime(0, 0, 0));
  });

  test('shold return a spaceMedia from the usecase', () {
    //Arrange
    when(() => mockUsecase(any()))
        .thenAnswer((_) async => Right(tSpaceMediaEntity));
    //Act
    homeStoreController.getSpaceMediaFromDate(tDateTime);
    //Assert
    homeStoreController.observer(onState: (state) {
      expect(state, tSpaceMediaModel);
      verify(() => mockUsecase(tDateTime)).called(1);
    });
  });

  final tFailure = ServerFailure();

  test('shold return a Failure from the usecase when there is an error', () {
    //Arrange
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(tFailure));
    //Act
    homeStoreController.getSpaceMediaFromDate(tDateTime);
    //Assert
    homeStoreController.observer(onError: (err) {
      expect(err, tFailure);
      verify(() => mockUsecase(tDateTime)).called(1);
    });
  });
}
