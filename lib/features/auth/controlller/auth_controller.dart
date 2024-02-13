import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sailordou/core/utils.dart';
import 'package:sailordou/features/auth/repository/auth_repository.dart';
import 'package:sailordou/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
        (l) => showSnackBar(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }
}
//   Stream<User?> get authStateChange => _authRepository.authStateChange;

//   void signInWithGoogle(BuildContext context, bool isFromLogin) async {
//     state = true;
//     final user = await _authRepository.signInWithGoogle(isFromLogin);
//     state = false;
//     user.fold(
//       (l) => showSnackBar(context, l.message),
//       (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
//     );
//   }

//   void signInAsGuest(BuildContext context) async {
//     state = true;
//     final user = await _authRepository.signInAsGuest();
//     state = false;
//     user.fold(
//       (l) => showSnackBar(context, l.message),
//       (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
//     );
//   }

//   Stream<UserModel> getUserData(String uid) {
//     return _authRepository.getUserData(uid);
//   }

//   void logout() async {
//     _authRepository.logOut();
//   }
// }
