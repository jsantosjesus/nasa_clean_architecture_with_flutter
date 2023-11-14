import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_with_flutter/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_with_flutter/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_with_flutter/features/domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImplemetation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplemetation(this.datasource);
  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
