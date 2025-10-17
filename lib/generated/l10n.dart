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

  /// `Home`
  String get navbar_home {
    return Intl.message('Home', name: 'navbar_home', desc: '', args: []);
  }

  /// `Favourites`
  String get navbar_favourites {
    return Intl.message(
      'Favourites',
      name: 'navbar_favourites',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get navbar_settings {
    return Intl.message(
      'Settings',
      name: 'navbar_settings',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get searh_no_results {
    return Intl.message(
      'No results found',
      name: 'searh_no_results',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get settings_notifications_title {
    return Intl.message(
      'Notifications',
      name: 'settings_notifications_title',
      desc: '',
      args: [],
    );
  }

  /// `Manage alerts`
  String get settings_notifications_subtitle {
    return Intl.message(
      'Manage alerts',
      name: 'settings_notifications_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language_title {
    return Intl.message(
      'Language',
      name: 'settings_language_title',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settings_language_subtitle {
    return Intl.message(
      'English',
      name: 'settings_language_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settings_theme_title {
    return Intl.message(
      'Theme',
      name: 'settings_theme_title',
      desc: '',
      args: [],
    );
  }

  /// `Light / Dark`
  String get settings_theme_subtitle {
    return Intl.message(
      'Light / Dark',
      name: 'settings_theme_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get settings_help_support_title {
    return Intl.message(
      'Help & Support',
      name: 'settings_help_support_title',
      desc: '',
      args: [],
    );
  }

  /// `Contact technical support`
  String get settings_help_support_subtitle {
    return Intl.message(
      'Contact technical support',
      name: 'settings_help_support_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get settings_about_title {
    return Intl.message(
      'About App',
      name: 'settings_about_title',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0.0`
  String get settings_about_subtitle {
    return Intl.message(
      'Version 1.0.0',
      name: 'settings_about_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get settings_logout {
    return Intl.message('Logout', name: 'settings_logout', desc: '', args: []);
  }

  /// `Arabic`
  String get settings_language_arabic {
    return Intl.message(
      'Arabic',
      name: 'settings_language_arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settings_language_english {
    return Intl.message(
      'English',
      name: 'settings_language_english',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get settings_language_change_button {
    return Intl.message(
      'Change Language',
      name: 'settings_language_change_button',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settings_theme_light {
    return Intl.message(
      'Light',
      name: 'settings_theme_light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settings_theme_dark {
    return Intl.message(
      'Dark',
      name: 'settings_theme_dark',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get settings_theme_change_button {
    return Intl.message(
      'Change Theme',
      name: 'settings_theme_change_button',
      desc: '',
      args: [],
    );
  }

  /// `Search here`
  String get home_search_bar_hint {
    return Intl.message(
      'Search here',
      name: 'home_search_bar_hint',
      desc: '',
      args: [],
    );
  }

  /// `No categories available`
  String get categories_no_categories {
    return Intl.message(
      'No categories available',
      name: 'categories_no_categories',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get categories_loading_placeholder {
    return Intl.message(
      'Loading...',
      name: 'categories_loading_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites_title {
    return Intl.message(
      'Favourites',
      name: 'favourites_title',
      desc: '',
      args: [],
    );
  }

  /// `No favourite stores yet`
  String get favourites_no_favourites {
    return Intl.message(
      'No favourite stores yet',
      name: 'favourites_no_favourites',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites_welcome_title {
    return Intl.message(
      'Favourites',
      name: 'favourites_welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to save your favourite stores list`
  String get favourites_welcome_subtitle {
    return Intl.message(
      'Sign in to save your favourite stores list',
      name: 'favourites_welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Error loading stores`
  String get stores_error_loading {
    return Intl.message(
      'Error loading stores',
      name: 'stores_error_loading',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get stores_retry {
    return Intl.message('Retry', name: 'stores_retry', desc: '', args: []);
  }

  /// `No more stores`
  String get stores_no_more {
    return Intl.message(
      'No more stores',
      name: 'stores_no_more',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to server`
  String get account_server_error_title {
    return Intl.message(
      'Unable to connect to server',
      name: 'account_server_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get account_server_error_unknown {
    return Intl.message(
      'Unknown error',
      name: 'account_server_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get account_server_error_retry {
    return Intl.message(
      'Retry',
      name: 'account_server_error_retry',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user_default_name {
    return Intl.message('User', name: 'user_default_name', desc: '', args: []);
  }

  /// `Verified Account`
  String get user_verified_account {
    return Intl.message(
      'Verified Account',
      name: 'user_verified_account',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get guest_welcome_title {
    return Intl.message(
      'Welcome',
      name: 'guest_welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to access your account`
  String get guest_welcome_subtitle {
    return Intl.message(
      'Sign in to access your account',
      name: 'guest_welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get coupon_copied {
    return Intl.message('Copied', name: 'coupon_copied', desc: '', args: []);
  }

  /// `Copy`
  String get coupon_copy {
    return Intl.message('Copy', name: 'coupon_copy', desc: '', args: []);
  }

  /// `No banners available at the moment`
  String get banner_no_banners {
    return Intl.message(
      'No banners available at the moment',
      name: 'banner_no_banners',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load banner`
  String get banner_error_loading {
    return Intl.message(
      'Failed to load banner',
      name: 'banner_error_loading',
      desc: '',
      args: [],
    );
  }

  /// `Pull to refresh or check connection`
  String get banner_error_subtitle {
    return Intl.message(
      'Pull to refresh or check connection',
      name: 'banner_error_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get google_signin_text {
    return Intl.message(
      'Sign in with Google',
      name: 'google_signin_text',
      desc: '',
      args: [],
    );
  }

  /// `Must be logged in first`
  String get favourites_login_required {
    return Intl.message(
      'Must be logged in first',
      name: 'favourites_login_required',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load favourites`
  String get favourites_load_failed {
    return Intl.message(
      'Failed to load favourites',
      name: 'favourites_load_failed',
      desc: '',
      args: [],
    );
  }

  /// `Connection problem`
  String get favourites_connection_error {
    return Intl.message(
      'Connection problem',
      name: 'favourites_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Update failed`
  String get favourites_update_failed {
    return Intl.message(
      'Update failed',
      name: 'favourites_update_failed',
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
