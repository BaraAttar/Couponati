import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @navbar_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navbar_home;

  /// No description provided for @navbar_favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get navbar_favourites;

  /// No description provided for @navbar_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navbar_settings;

  /// No description provided for @searh_no_results.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get searh_no_results;

  /// No description provided for @settings_notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications_title;

  /// No description provided for @settings_notifications_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage alerts'**
  String get settings_notifications_subtitle;

  /// No description provided for @settings_language_title.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language_title;

  /// No description provided for @settings_language_subtitle.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_subtitle;

  /// No description provided for @settings_theme_title.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme_title;

  /// No description provided for @settings_theme_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Light / Dark'**
  String get settings_theme_subtitle;

  /// No description provided for @settings_help_support_title.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settings_help_support_title;

  /// No description provided for @settings_help_support_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Contact technical support'**
  String get settings_help_support_subtitle;

  /// No description provided for @settings_about_title.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get settings_about_title;

  /// No description provided for @settings_about_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get settings_about_subtitle;

  /// No description provided for @settings_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settings_logout;

  /// No description provided for @settings_language_arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settings_language_arabic;

  /// No description provided for @settings_language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_english;

  /// No description provided for @settings_language_change_button.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get settings_language_change_button;

  /// No description provided for @settings_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// No description provided for @settings_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// No description provided for @settings_theme_change_button.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get settings_theme_change_button;

  /// No description provided for @home_search_bar_hint.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get home_search_bar_hint;

  /// No description provided for @categories_no_categories.
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get categories_no_categories;

  /// No description provided for @categories_loading_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get categories_loading_placeholder;

  /// No description provided for @favourites_title.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites_title;

  /// No description provided for @favourites_no_favourites.
  ///
  /// In en, this message translates to:
  /// **'No favourite stores yet'**
  String get favourites_no_favourites;

  /// No description provided for @favourites_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites_welcome_title;

  /// No description provided for @favourites_welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save your favourite stores list'**
  String get favourites_welcome_subtitle;

  /// No description provided for @stores_error_loading.
  ///
  /// In en, this message translates to:
  /// **'Error loading stores'**
  String get stores_error_loading;

  /// No description provided for @stores_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get stores_retry;

  /// No description provided for @stores_no_more.
  ///
  /// In en, this message translates to:
  /// **'No more stores'**
  String get stores_no_more;

  /// No description provided for @account_server_error_title.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to server'**
  String get account_server_error_title;

  /// No description provided for @account_server_error_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get account_server_error_unknown;

  /// No description provided for @account_server_error_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get account_server_error_retry;

  /// No description provided for @user_default_name.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user_default_name;

  /// No description provided for @user_verified_account.
  ///
  /// In en, this message translates to:
  /// **'Verified Account'**
  String get user_verified_account;

  /// No description provided for @guest_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get guest_welcome_title;

  /// No description provided for @guest_welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your account'**
  String get guest_welcome_subtitle;

  /// No description provided for @coupon_copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get coupon_copied;

  /// No description provided for @coupon_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get coupon_copy;

  /// No description provided for @banner_no_banners.
  ///
  /// In en, this message translates to:
  /// **'No banners available at the moment'**
  String get banner_no_banners;

  /// No description provided for @banner_error_loading.
  ///
  /// In en, this message translates to:
  /// **'Failed to load banner'**
  String get banner_error_loading;

  /// No description provided for @banner_error_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh or check connection'**
  String get banner_error_subtitle;

  /// No description provided for @google_signin_text.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get google_signin_text;

  /// No description provided for @favourites_login_required.
  ///
  /// In en, this message translates to:
  /// **'Must be logged in first'**
  String get favourites_login_required;

  /// No description provided for @favourites_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load favourites'**
  String get favourites_load_failed;

  /// No description provided for @favourites_connection_error.
  ///
  /// In en, this message translates to:
  /// **'Connection problem'**
  String get favourites_connection_error;

  /// No description provided for @favourites_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Update failed'**
  String get favourites_update_failed;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'en':
      return SEn();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
