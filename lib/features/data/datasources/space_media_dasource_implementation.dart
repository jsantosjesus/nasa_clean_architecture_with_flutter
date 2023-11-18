import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_with_flutter/core/utils/converters/date_toString_converter.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/models/space_media_model.dart';

class SpaceMediaDatasourceImplemetation implements ISpaceMediaDatasource {
  final DateToStringConverter converter;
  final http.Client client;

  SpaceMediaDatasourceImplemetation({
    required this.converter,
    required this.client,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.format(date);
    final response = await client.get(NasaEndpoints.getSpaceMedia(
      'DEMO_KEY',
      dateConverted,
    ));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
