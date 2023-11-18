import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeStoreController extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStoreController(this.usecase)
      : super(SpaceMediaEntity(
            description: '', mediaType: '', title: '', mediaUrl: ''));

  getSpaceMediaFromDate(DateTime? date) async {
    setLoading(true);
    final result = await usecase(date);
    result.fold((err) => setError(err), (success) => update(success));
    setLoading(false);
  }
}
