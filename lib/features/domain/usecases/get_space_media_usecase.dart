import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/usecase.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaUsecase implements Usecase<SpaceMediaEntity, NoParams> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaUsecase(this.repository);
  @override
  Future<Either<Failure, SpaceMediaEntity>> call(NoParams params)  async {
   await return repository.getSpaceMediaFromDate();
  }
}
