import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/features/authentication/presentation/view_model/cubits/cubit/auth_cubit.dart';
import 'package:chats_app/features/home/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:chats_app/features/home/presentation/manager/theme_cubit/app_themes.dart';
import 'package:chats_app/features/home/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:chats_app/features/profile/presentation/view_models/app_language_cubit/app_language_cubit.dart';
import 'package:chats_app/features/home/presentation/views/all_chats_view.dart';
import 'package:chats_app/features/search_users/presentation/views/users_view.dart';
import 'package:chats_app/firebase_options.dart';
import 'package:chats_app/generated/l10n.dart';
import 'package:chats_app/navigaton.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: 'https://koljiuhzxfeiibtreicu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtvbGppdWh6eGZlaWlidHJlaWN1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIyOTA5MDAsImV4cCI6MjA3Nzg2NjkwMH0.iCoGGVmN7XEIaJVCPsnDmxQsPrgkdmH1Xk4r7SxjvvI',
  );


  // تهيئة الكاش
  await CacheHelper.init();

  // نجيب اللغة المحفوظة (لو موجودة)
  final savedLang = CacheHelper.getData(key: "appLanguage") ?? "en";

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ChatsCubit()),
        BlocProvider(create: (_)=>AuthCubit()),
        BlocProvider(
          create: (_) => AppLanguageCubit()
            ..emit(AppLanguage(language: savedLang)),
        ),
      ],
      child: const ChatsApp(),
    ),
  );
}

class ChatsApp extends StatelessWidget {
  const ChatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLanguageCubit, AppLanguageState>(
      builder: (context, langState) {
        String currentLang = "en";
        if (langState is AppLanguage) currentLang = langState.language;

        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            final isDark = themeState is ThemeDark;

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              locale: Locale(currentLang),
              theme: isDark ? AppThemes.darkTheme : AppThemes.lightTheme,
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
      },
    );
  }
}
