part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeCubitInitial extends ThemeState {}
class ThemeLight extends ThemeState {}

class ThemeDark extends ThemeState {}
