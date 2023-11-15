import 'dart:convert';

import 'package:nasa_clean_architecture_with_flutter/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_with_flutter/core/utils/converters/date_toString_converter.dart';
import 'package:nasa_clean_architecture_with_flutter/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/models/space_media_model.dart';

class SpaceMediaDatasourceImplemetation implements ISpaceMediaDatasource {
  final HttpClient client;

  SpaceMediaDatasourceImplemetation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(
        NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
