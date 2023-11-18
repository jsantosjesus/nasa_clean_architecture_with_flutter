// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:nasa_clean_architecture_with_flutter/core/http_client/http_client.dart';
// import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/exceptions.dart';
// import 'package:nasa_clean_architecture_with_flutter/core/utils/converters/date_toString_converter.dart';
// import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_dasource_implementation.dart';
// import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_datasource.dart';
// import 'package:nasa_clean_architecture_with_flutter/features/data/models/space_media_model.dart';
// import 'package:http/http.dart' as http;

// import '../../../mocks/date_mock.dart';
// import '../../../mocks/space_media_mock.dart';

// class MockClient extends Mock implements http.Client {}

// class MockDateInputConverter extends Mock implements DateToStringConverter {}

// void main() {
//   late ISpaceMediaDatasource datasource;
//   late http.Client client;
//     late DateToStringConverter converter;

//   setUp(() {
//     client = MockClient();
//     converter = MockDateInputConverter();
//     datasource = SpaceMediaDatasourceImplemetation(client: client, converter: converter);
//   });

//   final tDateTimeString = '2021-02-02';

//   final tDateTime = DateTime(2021, 02, 02);


//   void successMock() {
//     when(() => converter.format(any())).thenReturn(tDateTimeString);
//     when(() => client.get(any()))
//         .thenAnswer((_) async => http.Response(spaceMediaMock, 200));
//   }

//   test('shold call the get method with correct url', () async {
//     // Arrange
//     successMock();
//     //Act
//     await datasource.getSpaceMediaFromDate(tDateTime);
//     //Assert
//     verify(() => client.get(urlExpected)).called(1);
//   });

//   test('shold return a spaceModel when is successful', () async {
//     // Arrange
//     successMock();
//     final tSpaceMediaModelExpected = SpaceMediaModel(
//         description: 'description',
//         mediaType: 'mediaType',
//         title: 'title',
//         mediaUrl: 'mediaUrl');

//     //Act
//     final result = await datasource.getSpaceMediaFromDate(tDateTime);
//     //Assert
//     expect(result, tSpaceMediaModelExpected);
//   });

//   test('shold throw a serverexception when the call is unccessful', () async {
//     // Arrange
//     when(() => client.get(any()))
//         .thenAnswer((_) async => HttpResponse(data: 'error', statusCode: 400));
//     //Act
//     final result = datasource.getSpaceMediaFromDate(tDateTime);
//     //Assert
//     expect(() => result, throwsA(ServerException()));
//   });
// }
