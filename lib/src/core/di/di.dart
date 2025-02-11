import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_and_guess/src/app/auth/data/repository/auth_repository.dart';
import 'package:draw_and_guess/src/app/auth/presentation/provider/auth_provider.dart';
import 'package:draw_and_guess/src/app/auth/presentation/provider/auth_state.dart';
import 'package:draw_and_guess/src/app/game/data/repository/game_repository.dart';
import 'package:draw_and_guess/src/app/game/presentation/provider/game_provider.dart';
import 'package:draw_and_guess/src/app/game/presentation/provider/game_state.dart';
import 'package:draw_and_guess/src/app/game/presentation/provider/timer_provider.dart';
import 'package:draw_and_guess/src/app/game/presentation/provider/timer_state.dart';
import 'package:draw_and_guess/src/app/start/data/repository/start_repository.dart';
import 'package:draw_and_guess/src/app/start/presentation/provider/start_provider.dart';
import 'package:draw_and_guess/src/app/start/presentation/provider/start_state.dart';
import 'package:draw_and_guess/src/core/provider/theme_provider.dart';
import 'package:draw_and_guess/src/core/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Providers
final authProvider = StateNotifierProvider<AuthProvider, AuthState>(
  (ref) => AuthProvider(
    authRepository: ref.read(authRepoProvider),
  ),
);

final startProvider = StateNotifierProvider<StartProvider, StartState>(
  (ref) => StartProvider(
    startRepository: ref.read(startRepoProvider),
  ),
);

final timerProvider = StateNotifierProvider<TimerProvider, TimerState>(
  (ref) => TimerProvider(),
);

final gameProvider = StateNotifierProvider<GameProvider, GameState>(
  (ref) => GameProvider(
    user: ref.read(authProvider).user,
    timerProvider: ref.read(timerProvider.notifier),
    gameRepository: ref.read(gameRepoProvider),
  ),
);

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeOptions>(
  (ref) => ThemeProvider(
    sharedPreferences: ref.read(sharedPreferencedProvider).value,
  ),
);

// Repositories
final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFireStoreProvider),
  ),
);

final startRepoProvider = Provider<StartRepository>(
  (ref) => StartRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFireStoreProvider),
  ),
);

final gameRepoProvider = Provider<GameRepository>(
  (ref) => GameRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFireStoreProvider),
  ),
);

// Externals
final firebaseFireStoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final sharedPreferencedProvider = FutureProvider<SharedPreferences>((_) {
  return SharedPreferences.getInstance();
});
