import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chats_app/cach/cach_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight()) {
    // عند إنشاء الكيوبت، جيب الحالة المحفوظة
    _loadSavedTheme();
  }

  bool get isDark => state is ThemeDark;

  void toggleTheme() {
    if (state is ThemeDark) {
      emit(ThemeLight());
      _saveTheme(false); // حفظ أن الوضع فاتح
    } else {
      emit(ThemeDark());
      _saveTheme(true); // حفظ أن الوضع مظلم
    }
  }

  // دالة لتحميل الثيم المحفوظ
  void _loadSavedTheme() {
    final isDarkMode = CacheHelper.getData(key: "isDarkMode") ?? false;
    if (isDarkMode == true) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }

  // دالة لحفظ الثيم في الكاش
  void _saveTheme(bool isDark) {
    CacheHelper.saveData(key: "isDarkMode", value: isDark);
  }
}