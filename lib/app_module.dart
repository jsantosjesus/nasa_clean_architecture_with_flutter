import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_architecture_with_flutter/core/utils/converters/date_toString_converter.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_dasource_implementation.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/repositories/space_media_repository_implemetation.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_architecture_with_flutter/features/presenter/controllers/home_store_controller.dart';

import 'features/presenter/pages/home_page.dart';
import 'features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStoreController(i())),
    Bind.lazySingleton((i) => GetSpaceMediaFromDateUsecase(i())),
    Bind.lazySingleton((i) => SpaceMediaRepositoryImplemetation(i())),
    Bind.lazySingleton(
        (i) => SpaceMediaDatasourceImplemetation(converter: i(), client: i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateToStringConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}
