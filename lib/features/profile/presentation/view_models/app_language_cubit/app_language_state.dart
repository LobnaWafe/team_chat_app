part of 'app_language_cubit.dart';

@immutable
sealed class AppLanguageState {}

final class AppLanguageInitial extends AppLanguageState {}
final class AppLanguage extends AppLanguageState {
  final String language;

  AppLanguage({required this.language});

}
