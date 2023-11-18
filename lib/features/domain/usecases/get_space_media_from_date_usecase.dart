import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/usecase.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);
  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime? date) async {
    return date != null
        ? await repository.getSpaceMediaFromDate(date)
        : Left(NullParamFailure());
  }
}
