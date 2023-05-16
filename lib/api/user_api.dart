import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/user_model.dart';

final userApiProvider = Provider(
  (ref) {
    final db = ref.watch(appWriteDatabaseProvider);
    return UserApi(db: db);
  },
);

abstract class IUserApi {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserApi implements IUserApi {
  final Databases _db;

  UserApi({required Databases db}) : _db = db;
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: ID.unique(),
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          message: e.message ?? "Some unexpected error occurred.",
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return left(
        Failure(
          message: e.toString(),
          stackTrace: st,
        ),
      );
    }
  }
}
