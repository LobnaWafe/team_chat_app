import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/features/profile/presentation/view_models/app_language_cubit/app_language_cubit.dart';
import 'package:chats_app/firebase_options.dart';
import 'package:chats_app/generated/l10n.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  // Initialize SharedPreferences
  await CacheHelper.init();

  // نجيب اللغة المحفوظة في الكاش (لو موجودة)
  final savedLang = CacheHelper.getData(key: "appLanguage") ?? "en";

  runApp(
    BlocProvider(
      create: (_) => AppLanguageCubit()
        ..emit(AppLanguage(language: savedLang)), // نبدأ بالـ language المحفوظة
      child: const ChatsApp(),
    ),
  );
}

class ChatsApp extends StatelessWidget {
  const ChatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLanguageCubit, AppLanguageState>(
      builder: (context, state) {
        // نحدد اللغة الحالية
        String currentLang = "en"; // الافتراضي
        if (state is AppLanguage) currentLang = state.language;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: Locale(currentLang),
          routerConfig: AppRouter.router,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
