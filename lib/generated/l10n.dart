// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Name`
  String get profileName {
    return Intl.message('Name', name: 'profileName', desc: '', args: []);
  }

  /// `Email`
  String get profileEmail {
    return Intl.message('Email', name: 'profileEmail', desc: '', args: []);
  }

  /// `App Language`
  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language {
    return Intl.message('English', name: 'language', desc: '', args: []);
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `Type yor message`
  String get hintTextChatPage {
    return Intl.message(
      'Type yor message',
      name: 'hintTextChatPage',
      desc: '',
      args: [],
    );
  }

  /// `No Users yet`
  String get No_Users_yet {
    return Intl.message(
      'No Users yet',
      name: 'No_Users_yet',
      desc: '',
      args: [],
    );
  }

  /// `New Chat`
  String get NewChat {
    return Intl.message('New Chat', name: 'NewChat', desc: '', args: []);
  }

  /// `Search...`
  String get Search {
    return Intl.message('Search...', name: 'Search', desc: '', args: []);
  }

  /// `My Chats`
  String get MyChats {
    return Intl.message('My Chats', name: 'MyChats', desc: '', args: []);
  }

  /// `Start your conversations`
  String get Welcome {
    return Intl.message(
      'Start your conversations',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message('Sign In', name: 'SignIn', desc: '', args: []);
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message('Sign Up', name: 'SignUp', desc: '', args: []);
  }

  /// `Logging in...`
  String get LoggingIn {
    return Intl.message('Logging in...', name: 'LoggingIn', desc: '', args: []);
  }

  /// `Login`
  String get Login {
    return Intl.message('Login', name: 'Login', desc: '', args: []);
  }

  /// `Email`
  String get Email {
    return Intl.message('Email', name: 'Email', desc: '', args: []);
  }

  /// `Password`
  String get Password {
    return Intl.message('Password', name: 'Password', desc: '', args: []);
  }

  /// `Enter your email`
  String get Enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'Enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get Enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'Enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Creating account...`
  String get CreatingAccount {
    return Intl.message(
      'Creating account...',
      name: 'CreatingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get Enter_your_name {
    return Intl.message(
      'Enter your name',
      name: 'Enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get Already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'Already_have_account',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
