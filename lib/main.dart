import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/routes/router.dart';

import 'main.config.dart';

final getIt = GetIt.instance;

void main() {
  configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

@InjectableInit()
void configureDependencies() => getIt.init();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 사용자 정의 라이트 테마
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E88E5), // primary
            brightness: Brightness.light,
          ).copyWith(
            surface: const Color(0xFFFFFFFF),
            onSurface: const Color(0xFF000000), // text
            secondary: const Color(0xFFFF4081), // accent
            onSurfaceVariant: const Color(0xFF4F4F4F), // secondaryText
          ),
    );

    // 사용자 정의 다크 테마
    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E88E5), // primary
            brightness: Brightness.dark,
          ).copyWith(
            surface: const Color(0xFF121212),
            onSurface: const Color(0xFFFFFFFF), // text
            secondary: const Color(0xFFFF4081), // accent
            onSurfaceVariant: const Color(0xFFB0B0B0), // secondaryText
          ),
    );

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
