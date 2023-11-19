import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_with_flutter/core/utils/converters/date_toString_converter.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_dasource_implementation.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class MockDateInputConverter extends Mock implements DateToStringConverter {}

class MockClient extends Mock implements http.Client {}

void main() {
  late SpaceMediaDatasourceImplemetation datasource;
  late DateToStringConverter converter;
  late http.Client client;

  setUp(() {
    converter = MockDateInputConverter();
    client = MockClient();
    datasource = SpaceMediaDatasourceImplemetation(
      converter: converter,
      client: client,
    );
    registerFallbackValue(DateTime(2000));
    registerFallbackValue(Uri());
  });

  final tDateTimeString = '2021-02-02';

  final tDateTime = DateTime(2021, 02, 02);

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );
  void successMock() {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response(spaceMediaMock, 200));
  }

  test('should call DateInputConverter to convert the DateTime into a String',
      () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => converter.format(tDateTime)).called(1);
  });

  test('should call the get method with correct url', () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'DEMO_KEY',
          'date': '2021-02-02',
        }))).called(1);
  });
  test('should return a SpaceMediaModel when the call is successful', () async {
    // Arrange
    successMock();
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModel);
    verify(() => converter.format(tDateTime)).called(1);
  });
  test('should throw a ServerException when the call is unccessful', () async {
    // Arrange
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response('something went wrong', 400));
    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerException()));
    verify(() => converter.format(tDateTime)).called(1);
  });
}
