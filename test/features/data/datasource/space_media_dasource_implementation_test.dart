import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_with_flutter/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_with_flutter/core/utils/converters/date_toString_converter.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_dasource_implementation.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = SpaceMediaDatasourceImplemetation(client);
  });

  final DateTime tDateTime = DateTime(2023, 11, 15);
  final urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2023-11-15';
  DateToStringConverter.convert(tDateTime);

  void successMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('shold call the get method with correct url', () async {
    // Arrange
    successMock();
    //Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    //Assert
    verify(() => client.get(urlExpected)).called(1);
  });

  test('shold return a spaceModel when is successful', () async {
    // Arrange
    successMock();
    final tSpaceMediaModelExpected = SpaceMediaModel(
        description: 'description',
        mediaType: 'mediaType',
        title: 'title',
        mediaUrl: 'mediaUrl');

    //Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    //Assert
    expect(result, tSpaceMediaModelExpected);
  });

  test('shold throw a serverexception when the call is unccessful', () async {
    // Arrange
    when(() => client.get(any()))
        .thenAnswer((_) async => HttpResponse(data: 'error', statusCode: 400));
    //Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    //Assert
    expect(() => result, throwsA(ServerException()));
  });
}
