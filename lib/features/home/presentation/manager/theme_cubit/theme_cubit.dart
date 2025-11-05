import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight());

  bool get isDark => state is ThemeDark;

  void toggleTheme() {
    if (state is ThemeDark) {
      emit(ThemeLight());
    } else {
      emit(ThemeDark());
    }
  }
}
