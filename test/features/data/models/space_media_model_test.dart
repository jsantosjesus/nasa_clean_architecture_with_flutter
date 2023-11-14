import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/models/space_media_model.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
      description: 'description',
      mediaType: 'mediaType',
      title: 'title',
      mediaUrl: 'mediaUrl');
  setUp(() {});

  test('shold be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('shold return a valid model', () {
    //Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediMock);
    //Act
    final result = SpaceMediaModel.fromJson(jsonMap);
    //Assert
    expect(result, tSpaceMediaModel);
  });

  test('shold return a json map', () {
    //Arrange
    final expectMap = {
      "explanation": "description",
      "media_type": "mediaType",
      "title": "title",
      "url": "mediaUrl"
    };
    //Act
    final result = tSpaceMediaModel.toJson();
    //Assert
    expect(result, expectMap);
  });
}
