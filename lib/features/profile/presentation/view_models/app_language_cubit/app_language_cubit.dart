import 'package:bloc/bloc.dart';
import 'package:chats_app/cach/cach_helper.dart';
import 'package:meta/meta.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(AppLanguageInitial());

  String globalLangValue="en";

  void changeLnguageMethod()async{
    final savedLang = CacheHelper.getData(key: "appLanguage");
   final newLang = savedLang == "ar" ? "en" : "ar";

   globalLangValue=newLang;

    await CacheHelper.saveData(key: "appLanguage", value: newLang);
   emit( AppLanguage(language:newLang));
  
  }

}
