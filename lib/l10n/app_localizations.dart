import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
    Locale('hi')
  ];

  /// No description provided for @l_heading.
  ///
  /// In en, this message translates to:
  /// **'Social Media Services'**
  String get l_heading;

  /// No description provided for @l_choose_language.
  ///
  /// In en, this message translates to:
  /// **'Choose Any Language'**
  String get l_choose_language;

  /// No description provided for @l_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get l_description;

  /// No description provided for @l_description2.
  ///
  /// In en, this message translates to:
  /// **'Description2'**
  String get l_description2;

  /// No description provided for @l_get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get l_get_started;

  /// No description provided for @m_ent_mob_no.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get m_ent_mob_no;

  /// No description provided for @m_sub1.
  ///
  /// In en, this message translates to:
  /// **'We will send you an OTP for verify your mobile number.'**
  String get m_sub1;

  /// No description provided for @m_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get m_continue;

  /// No description provided for @m_snack.
  ///
  /// In en, this message translates to:
  /// **'Please Enter a Valid Mobile Number'**
  String get m_snack;

  /// No description provided for @m_10digits.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number must not be above 10 digits'**
  String get m_10digits;

  /// No description provided for @t_1.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to '**
  String get t_1;

  /// No description provided for @t_2.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get t_2;

  /// No description provided for @o_verification.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get o_verification;

  /// No description provided for @o_pls_type.
  ///
  /// In en, this message translates to:
  /// **'Please type the verification code send to '**
  String get o_pls_type;

  /// No description provided for @o_dont.
  ///
  /// In en, this message translates to:
  /// **'Don\'t get the code? '**
  String get o_dont;

  /// No description provided for @o_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get o_resend;

  /// No description provided for @o_verify.
  ///
  /// In en, this message translates to:
  /// **'Verify Now'**
  String get o_verify;

  /// No description provided for @o_snack.
  ///
  /// In en, this message translates to:
  /// **'Enter a Valid OTP'**
  String get o_snack;

  /// No description provided for @e_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get e_name;

  /// No description provided for @e_name_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get e_name_h;

  /// No description provided for @e_dob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get e_dob;

  /// No description provided for @e_dob_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Date of Birth'**
  String get e_dob_h;

  /// No description provided for @e_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get e_gender;

  /// No description provided for @e_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get e_male;

  /// No description provided for @e_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get e_female;

  /// No description provided for @e_country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get e_country;

  /// No description provided for @e_country_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Country'**
  String get e_country_h;

  /// No description provided for @e_region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get e_region;

  /// No description provided for @e_region_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Region'**
  String get e_region_h;

  /// No description provided for @e_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get e_state;

  /// No description provided for @e_state_h.
  ///
  /// In en, this message translates to:
  /// **'Enter State'**
  String get e_state_h;

  /// No description provided for @e_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get e_about;

  /// No description provided for @e_about_h.
  ///
  /// In en, this message translates to:
  /// **'Enter About'**
  String get e_about_h;

  /// No description provided for @e_save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get e_save;

  /// No description provided for @d_my_profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get d_my_profile;

  /// No description provided for @d_address.
  ///
  /// In en, this message translates to:
  /// **'Address Book'**
  String get d_address;

  /// No description provided for @d_become.
  ///
  /// In en, this message translates to:
  /// **'Become a Service Man'**
  String get d_become;

  /// No description provided for @d_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get d_privacy;

  /// No description provided for @d_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get d_logout;

  /// No description provided for @d_add_service.
  ///
  /// In en, this message translates to:
  /// **'Add Service'**
  String get d_add_service;

  /// No description provided for @p_first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get p_first_name;

  /// No description provided for @p_first_name_h.
  ///
  /// In en, this message translates to:
  /// **'Enter First Name'**
  String get p_first_name_h;

  /// No description provided for @p_last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get p_last_name;

  /// No description provided for @p_last_name_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Last Name'**
  String get p_last_name_h;

  /// No description provided for @p_email_h.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get p_email_h;

  /// No description provided for @p_civil.
  ///
  /// In en, this message translates to:
  /// **'Civil Card No'**
  String get p_civil;

  /// No description provided for @p_civil_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Card No'**
  String get p_civil_h;

  /// No description provided for @p_dob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get p_dob;

  /// No description provided for @p_dob_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Date of Birth'**
  String get p_dob_h;

  /// No description provided for @p_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get p_gender;

  /// No description provided for @p_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get p_male;

  /// No description provided for @p_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get p_female;

  /// No description provided for @p_country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get p_country;

  /// No description provided for @p_country_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Country'**
  String get p_country_h;

  /// No description provided for @p_region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get p_region;

  /// No description provided for @p_region_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Region'**
  String get p_region_h;

  /// No description provided for @p_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get p_state;

  /// No description provided for @p_state_h.
  ///
  /// In en, this message translates to:
  /// **'Enter State'**
  String get p_state_h;

  /// No description provided for @p_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get p_city;

  /// No description provided for @p_city_h.
  ///
  /// In en, this message translates to:
  /// **'Enter City'**
  String get p_city_h;

  /// No description provided for @p_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get p_address;

  /// No description provided for @p_address_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Address'**
  String get p_address_h;

  /// No description provided for @p_continue.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get p_continue;

  /// No description provided for @c_service_group.
  ///
  /// In en, this message translates to:
  /// **'Service Group'**
  String get c_service_group;

  /// No description provided for @c_service_group_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Group'**
  String get c_service_group_h;

  /// No description provided for @c_service_list.
  ///
  /// In en, this message translates to:
  /// **'Service List'**
  String get c_service_list;

  /// No description provided for @c_service_list_h1.
  ///
  /// In en, this message translates to:
  /// **'Enter List'**
  String get c_service_list_h1;

  /// No description provided for @c_service_list_h.
  ///
  /// In en, this message translates to:
  /// **'Service List'**
  String get c_service_list_h;

  /// No description provided for @c_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Registration Card/ CR Copy'**
  String get c_vehicle;

  /// No description provided for @c_browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get c_browse;

  /// No description provided for @c_pay.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE TO PAY'**
  String get c_pay;

  /// No description provided for @c_snack.
  ///
  /// In en, this message translates to:
  /// **'Please agree the terms and condition'**
  String get c_snack;

  /// No description provided for @s_servicer.
  ///
  /// In en, this message translates to:
  /// **'Servicer'**
  String get s_servicer;

  /// No description provided for @s_country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get s_country;

  /// No description provided for @s_region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get s_region;

  /// No description provided for @s_map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get s_map;

  /// No description provided for @s_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get s_state;

  /// No description provided for @s_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get s_continue;

  /// No description provided for @s_advanced_search.
  ///
  /// In en, this message translates to:
  /// **'Advanced Search'**
  String get s_advanced_search;

  /// No description provided for @s_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get s_search;

  /// No description provided for @s_search_country.
  ///
  /// In en, this message translates to:
  /// **'Search a country'**
  String get s_search_country;

  /// No description provided for @s_two.
  ///
  /// In en, this message translates to:
  /// **'Two-Wheeler'**
  String get s_two;

  /// No description provided for @s_four.
  ///
  /// In en, this message translates to:
  /// **'Four-Wheeler'**
  String get s_four;

  /// No description provided for @cp_photo1.
  ///
  /// In en, this message translates to:
  /// **'Photo & Video'**
  String get cp_photo1;

  /// No description provided for @cp_photo2.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get cp_photo2;

  /// No description provided for @cp_doc.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get cp_doc;

  /// No description provided for @cp_loc.
  ///
  /// In en, this message translates to:
  /// **'Share Location'**
  String get cp_loc;

  /// No description provided for @cp_s_loc_1.
  ///
  /// In en, this message translates to:
  /// **'Send Current'**
  String get cp_s_loc_1;

  /// No description provided for @cp_s_loc_2.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get cp_s_loc_2;

  /// No description provided for @cp_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose From App'**
  String get cp_choose;

  /// No description provided for @cp_address.
  ///
  /// In en, this message translates to:
  /// **'Address Card'**
  String get cp_address;

  /// No description provided for @cp_long_press.
  ///
  /// In en, this message translates to:
  /// **'Long press to record'**
  String get cp_long_press;

  /// No description provided for @cp_re.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get cp_re;

  /// No description provided for @cs_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get cs_profile;

  /// No description provided for @cs_choose_service.
  ///
  /// In en, this message translates to:
  /// **'Choose Service'**
  String get cs_choose_service;

  /// No description provided for @cs_pay.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get cs_pay;

  /// No description provided for @ps_card.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get ps_card;

  /// No description provided for @ps_card_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Holder Name'**
  String get ps_card_h;

  /// No description provided for @ps_card_no.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get ps_card_no;

  /// No description provided for @ps_card_no_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Card No'**
  String get ps_card_no_h;

  /// No description provided for @ps_ex.
  ///
  /// In en, this message translates to:
  /// **'Expired Date'**
  String get ps_ex;

  /// No description provided for @ps_cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV Code'**
  String get ps_cvv;

  /// No description provided for @ps_cvv_h.
  ///
  /// In en, this message translates to:
  /// **'Enter CVV'**
  String get ps_cvv_h;

  /// No description provided for @ps_coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon Code'**
  String get ps_coupon;

  /// No description provided for @ps_coupon_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Coupon Code'**
  String get ps_coupon_h;

  /// No description provided for @ps_yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly Plan'**
  String get ps_yearly;

  /// No description provided for @ps_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly Plan'**
  String get ps_monthly;

  /// No description provided for @ps_pay.
  ///
  /// In en, this message translates to:
  /// **'PAY NOW'**
  String get ps_pay;

  /// No description provided for @pp_my_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get pp_my_profile;

  /// No description provided for @pp_message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get pp_message;

  /// No description provided for @pp_favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get pp_favourites;

  /// No description provided for @pp_address.
  ///
  /// In en, this message translates to:
  /// **'Address Book'**
  String get pp_address;

  /// No description provided for @pp_settings1.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get pp_settings1;

  /// No description provided for @pp_settings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get pp_settings;

  /// No description provided for @pp_my_Services.
  ///
  /// In en, this message translates to:
  /// **'My Services'**
  String get pp_my_Services;

  /// No description provided for @pp_my_sub.
  ///
  /// In en, this message translates to:
  /// **'My Subscription'**
  String get pp_my_sub;

  /// No description provided for @pp_no_sub.
  ///
  /// In en, this message translates to:
  /// **'No subscription available'**
  String get pp_no_sub;

  /// No description provided for @w_wishList.
  ///
  /// In en, this message translates to:
  /// **'WishList'**
  String get w_wishList;

  /// No description provided for @pr_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get pr_privacy;

  /// No description provided for @su_success.
  ///
  /// In en, this message translates to:
  /// **'Payment Successfull'**
  String get su_success;

  /// No description provided for @su_title.
  ///
  /// In en, this message translates to:
  /// **'Your payment was successfully processed'**
  String get su_title;

  /// No description provided for @su_title_1.
  ///
  /// In en, this message translates to:
  /// **'Detail of transaction are included'**
  String get su_title_1;

  /// No description provided for @su_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get su_date;

  /// No description provided for @su_time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get su_time;

  /// No description provided for @su_service_fee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get su_service_fee;

  /// No description provided for @su_discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get su_discount;

  /// No description provided for @su_offerprice.
  ///
  /// In en, this message translates to:
  /// **'Offer price'**
  String get su_offerprice;

  /// No description provided for @su_vat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get su_vat;

  /// No description provided for @su_mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile No'**
  String get su_mobile;

  /// No description provided for @su_exp.
  ///
  /// In en, this message translates to:
  /// **'Exp Date'**
  String get su_exp;

  /// No description provided for @su_save_pdf.
  ///
  /// In en, this message translates to:
  /// **'SAVE PDF'**
  String get su_save_pdf;

  /// No description provided for @su_home.
  ///
  /// In en, this message translates to:
  /// **'BACK TO HOME'**
  String get su_home;

  /// No description provided for @su_grand_total.
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get su_grand_total;

  /// No description provided for @su_coupon_discount.
  ///
  /// In en, this message translates to:
  /// **'Coupon Discount'**
  String get su_coupon_discount;

  /// No description provided for @su_tax_amount.
  ///
  /// In en, this message translates to:
  /// **'Tax Amount'**
  String get su_tax_amount;

  /// No description provided for @su_sub_date.
  ///
  /// In en, this message translates to:
  /// **'Subscription Date'**
  String get su_sub_date;

  /// No description provided for @su_order_id.
  ///
  /// In en, this message translates to:
  /// **'Order Id'**
  String get su_order_id;

  /// No description provided for @su_package_id.
  ///
  /// In en, this message translates to:
  /// **'Package Name'**
  String get su_package_id;

  /// No description provided for @a_home_locator.
  ///
  /// In en, this message translates to:
  /// **'Home Locator'**
  String get a_home_locator;

  /// No description provided for @a_add.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get a_add;

  /// No description provided for @a_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get a_address;

  /// No description provided for @a_home.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get a_home;

  /// No description provided for @a_cover.
  ///
  /// In en, this message translates to:
  /// **'Please choose cover Photo'**
  String get a_cover;

  /// No description provided for @a_add_cover.
  ///
  /// In en, this message translates to:
  /// **'Please Choose an Address Cover Photo'**
  String get a_add_cover;

  /// No description provided for @ae_home_locator.
  ///
  /// In en, this message translates to:
  /// **'Change home Location'**
  String get ae_home_locator;

  /// No description provided for @ae_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get ae_add;

  /// No description provided for @ae_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get ae_address;

  /// No description provided for @ae_address_n.
  ///
  /// In en, this message translates to:
  /// **'Address Name'**
  String get ae_address_n;

  /// No description provided for @ae_address_h2.
  ///
  /// In en, this message translates to:
  /// **'Enter Address Name'**
  String get ae_address_h2;

  /// No description provided for @ae_address_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Address'**
  String get ae_address_h;

  /// No description provided for @ae_country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get ae_country;

  /// No description provided for @ae_country_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Country'**
  String get ae_country_h;

  /// No description provided for @ae_region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get ae_region;

  /// No description provided for @ae_region_h.
  ///
  /// In en, this message translates to:
  /// **'Enter Region'**
  String get ae_region_h;

  /// No description provided for @ae_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get ae_state;

  /// No description provided for @ae_state_h.
  ///
  /// In en, this message translates to:
  /// **'Enter State'**
  String get ae_state_h;

  /// No description provided for @ae_home_flat.
  ///
  /// In en, this message translates to:
  /// **'Home/Flat no'**
  String get ae_home_flat;

  /// No description provided for @ae_no.
  ///
  /// In en, this message translates to:
  /// **'Enter Number'**
  String get ae_no;

  /// No description provided for @ae_save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get ae_save;

  /// No description provided for @ae_cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get ae_cancel;

  /// No description provided for @se_services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get se_services;

  /// No description provided for @se_sub_services.
  ///
  /// In en, this message translates to:
  /// **'Sub Services'**
  String get se_sub_services;

  /// No description provided for @wd_desc.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get wd_desc;

  /// No description provided for @wd_ser.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get wd_ser;

  /// No description provided for @wd_tran.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get wd_tran;

  /// No description provided for @wd_more.
  ///
  /// In en, this message translates to:
  /// **'More Details'**
  String get wd_more;

  /// No description provided for @wd_report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get wd_report;

  /// No description provided for @wd_block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get wd_block;

  /// No description provided for @we_desc.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get we_desc;

  /// No description provided for @we_ser.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get we_ser;

  /// No description provided for @we_tran.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get we_tran;

  /// No description provided for @we_save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get we_save;

  /// No description provided for @we_report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get we_report;

  /// No description provided for @we_block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get we_block;

  /// No description provided for @wd_online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get wd_online;

  /// No description provided for @wd_offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get wd_offline;

  /// No description provided for @wd_busy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get wd_busy;

  /// No description provided for @sd_status.
  ///
  /// In en, this message translates to:
  /// **'Service Status'**
  String get sd_status;

  /// No description provided for @sd_available.
  ///
  /// In en, this message translates to:
  /// **'Available Transport:'**
  String get sd_available;

  /// No description provided for @sd_type.
  ///
  /// In en, this message translates to:
  /// **'Service Type:'**
  String get sd_type;

  /// No description provided for @sd_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get sd_reset;

  /// No description provided for @mh_message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get mh_message;

  /// No description provided for @mh_recents.
  ///
  /// In en, this message translates to:
  /// **'Recents'**
  String get mh_recents;

  /// No description provided for @ps_snack_card.
  ///
  /// In en, this message translates to:
  /// **'Please Enter A Card Holder Name'**
  String get ps_snack_card;

  /// No description provided for @ps_snack_card_no.
  ///
  /// In en, this message translates to:
  /// **'Please enter a card number'**
  String get ps_snack_card_no;

  /// No description provided for @ps_snack_expiry.
  ///
  /// In en, this message translates to:
  /// **'Please enter card expiry date'**
  String get ps_snack_expiry;

  /// No description provided for @ps_snack_cvv.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Civil Card Number'**
  String get ps_snack_cvv;

  /// No description provided for @ps_snack_package.
  ///
  /// In en, this message translates to:
  /// **'Please choose a package to continue'**
  String get ps_snack_package;

  /// No description provided for @ps_snack_coupen.
  ///
  /// In en, this message translates to:
  /// **'Please enter a coupon code to redeem'**
  String get ps_snack_coupen;

  /// No description provided for @e_snack_name.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get e_snack_name;

  /// No description provided for @e_snack_dob.
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get e_snack_dob;

  /// No description provided for @e_snack_country_field.
  ///
  /// In en, this message translates to:
  /// **'Country field can not be empty'**
  String get e_snack_country_field;

  /// No description provided for @sv_edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get sv_edit_profile;

  /// No description provided for @sv_no_images.
  ///
  /// In en, this message translates to:
  /// **'No images to display'**
  String get sv_no_images;

  /// No description provided for @se_transport_ty.
  ///
  /// In en, this message translates to:
  /// **'Select Transport Type'**
  String get se_transport_ty;

  /// No description provided for @ms_Sub.
  ///
  /// In en, this message translates to:
  /// **'Subscription Date :'**
  String get ms_Sub;

  /// No description provided for @ms_exp.
  ///
  /// In en, this message translates to:
  /// **'Exp Date :'**
  String get ms_exp;

  /// No description provided for @ms_new.
  ///
  /// In en, this message translates to:
  /// **'New Services'**
  String get ms_new;

  /// No description provided for @ms_my.
  ///
  /// In en, this message translates to:
  /// **'My Services'**
  String get ms_my;

  /// No description provided for @ms_ordered.
  ///
  /// In en, this message translates to:
  /// **'Ordered Services'**
  String get ms_ordered;

  /// No description provided for @msb_renew.
  ///
  /// In en, this message translates to:
  /// **'RENEW'**
  String get msb_renew;

  /// No description provided for @msb_exp.
  ///
  /// In en, this message translates to:
  /// **'Exp Date :'**
  String get msb_exp;

  /// No description provided for @msb_pur.
  ///
  /// In en, this message translates to:
  /// **'Purchase Date :'**
  String get msb_pur;

  /// No description provided for @msb_sub.
  ///
  /// In en, this message translates to:
  /// **'My Subscription'**
  String get msb_sub;

  /// No description provided for @snack_coupen_av.
  ///
  /// In en, this message translates to:
  /// **'No coupon code available'**
  String get snack_coupen_av;

  /// No description provided for @snack_get_location.
  ///
  /// In en, this message translates to:
  /// **'Getting Current Location...'**
  String get snack_get_location;

  /// No description provided for @snack_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get snack_done;

  /// No description provided for @snack_choose_group.
  ///
  /// In en, this message translates to:
  /// **'Please choose a service group'**
  String get snack_choose_group;

  /// No description provided for @snack_upload.
  ///
  /// In en, this message translates to:
  /// **'Please choose a sub service'**
  String get snack_upload;

  /// No description provided for @snack_upload_file.
  ///
  /// In en, this message translates to:
  /// **'Please choose a file'**
  String get snack_upload_file;

  /// No description provided for @snack_no_address.
  ///
  /// In en, this message translates to:
  /// **'No Address Available'**
  String get snack_no_address;

  /// No description provided for @snack_phone_digits.
  ///
  /// In en, this message translates to:
  /// **'Mobile number must not be below 8 digits'**
  String get snack_phone_digits;

  /// No description provided for @snack_enable_loc.
  ///
  /// In en, this message translates to:
  /// **'Enable Location for further access'**
  String get snack_enable_loc;

  /// No description provided for @snack_message_sent.
  ///
  /// In en, this message translates to:
  /// **'The Message can\'t be sent at the Moment'**
  String get snack_message_sent;

  /// No description provided for @snack_customer_report.
  ///
  /// In en, this message translates to:
  /// **'Reported customer successfully'**
  String get snack_customer_report;

  /// No description provided for @snack_package.
  ///
  /// In en, this message translates to:
  /// **'There is no subscription package available under this services. Please choose another service'**
  String get snack_package;

  /// No description provided for @gm_new_location.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Location'**
  String get gm_new_location;

  /// No description provided for @gm_choose_location.
  ///
  /// In en, this message translates to:
  /// **'Choose Location'**
  String get gm_choose_location;

  /// No description provided for @gm_search.
  ///
  /// In en, this message translates to:
  /// **'Search google map'**
  String get gm_search;

  /// No description provided for @gm_search_servicer.
  ///
  /// In en, this message translates to:
  /// **'Search Servicer on this Location'**
  String get gm_search_servicer;

  /// No description provided for @no_connection.
  ///
  /// In en, this message translates to:
  /// **'Slow or no internet connection'**
  String get no_connection;

  /// No description provided for @no_check_connection.
  ///
  /// In en, this message translates to:
  /// **'Check your internet settings'**
  String get no_check_connection;

  /// No description provided for @no_oops.
  ///
  /// In en, this message translates to:
  /// **'Ooops !'**
  String get no_oops;

  /// No description provided for @di_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete address field!'**
  String get di_delete;

  /// No description provided for @di_delete2.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to'**
  String get di_delete2;

  /// No description provided for @di_delete3.
  ///
  /// In en, this message translates to:
  /// **'delete'**
  String get di_delete3;

  /// No description provided for @di_deleteimg.
  ///
  /// In en, this message translates to:
  /// **'Delete Image!'**
  String get di_deleteimg;

  /// No description provided for @di_dont.
  ///
  /// In en, this message translates to:
  /// **'I Don\'t Want To'**
  String get di_dont;

  /// No description provided for @di_allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get di_allow;

  /// No description provided for @pay_fail.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get pay_fail;

  /// No description provided for @redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get redeem;

  /// No description provided for @validity.
  ///
  /// In en, this message translates to:
  /// **'Validity'**
  String get validity;

  /// No description provided for @tax_total.
  ///
  /// In en, this message translates to:
  /// **'Tax Amount'**
  String get tax_total;

  /// No description provided for @fetch_loc.
  ///
  /// In en, this message translates to:
  /// **'Location Fetching...'**
  String get fetch_loc;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'paid'**
  String get paid;

  /// No description provided for @omr.
  ///
  /// In en, this message translates to:
  /// **'OMR'**
  String get omr;

  /// No description provided for @re_reason.
  ///
  /// In en, this message translates to:
  /// **'Enter A reason to proceed'**
  String get re_reason;

  /// No description provided for @re_reason2.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get re_reason2;

  /// No description provided for @re_comment.
  ///
  /// In en, this message translates to:
  /// **'Enter A Comment to proceed'**
  String get re_comment;

  /// No description provided for @re_comment2.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get re_comment2;

  /// No description provided for @re_report_user.
  ///
  /// In en, this message translates to:
  /// **'Report User'**
  String get re_report_user;

  /// No description provided for @re_bother.
  ///
  /// In en, this message translates to:
  /// **'is this person bothering you?'**
  String get re_bother;

  /// No description provided for @re_tell_us.
  ///
  /// In en, this message translates to:
  /// **'Tell us what they did.'**
  String get re_tell_us;

  /// No description provided for @re_report_success.
  ///
  /// In en, this message translates to:
  /// **'Reported Customer Successfully'**
  String get re_report_success;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get yesterday;

  /// No description provided for @address_locator.
  ///
  /// In en, this message translates to:
  /// **'Find Location'**
  String get address_locator;

  /// No description provided for @a_address_photo.
  ///
  /// In en, this message translates to:
  /// **'Please choose an address Photo'**
  String get a_address_photo;

  /// No description provided for @a_address_name_req.
  ///
  /// In en, this message translates to:
  /// **'Address name field is required'**
  String get a_address_name_req;

  /// No description provided for @a_address_req.
  ///
  /// In en, this message translates to:
  /// **'Address field is required'**
  String get a_address_req;

  /// No description provided for @a_country.
  ///
  /// In en, this message translates to:
  /// **'Select a country'**
  String get a_country;

  /// No description provided for @a_region.
  ///
  /// In en, this message translates to:
  /// **'Region is required'**
  String get a_region;

  /// No description provided for @a_state.
  ///
  /// In en, this message translates to:
  /// **'State is required'**
  String get a_state;

  /// No description provided for @a_flat.
  ///
  /// In en, this message translates to:
  /// **'Flat No is required'**
  String get a_flat;

  /// No description provided for @a_loc.
  ///
  /// In en, this message translates to:
  /// **'Please choose an address location'**
  String get a_loc;

  /// No description provided for @sl_select.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get sl_select;

  /// No description provided for @su_invoice_id.
  ///
  /// In en, this message translates to:
  /// **'Invoice id'**
  String get su_invoice_id;

  /// No description provided for @hw_title.
  ///
  /// In en, this message translates to:
  /// **'How To Work'**
  String get hw_title;

  /// No description provided for @hw_title2.
  ///
  /// In en, this message translates to:
  /// **'How To Work Overall Tuw Services'**
  String get hw_title2;

  /// No description provided for @hw_des.
  ///
  /// In en, this message translates to:
  /// **'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'**
  String get hw_des;

  /// No description provided for @hw_learn.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get hw_learn;

  /// No description provided for @hw_mc_1.
  ///
  /// In en, this message translates to:
  /// **'1. Register Mobile Number'**
  String get hw_mc_1;

  /// No description provided for @hw_mc_2.
  ///
  /// In en, this message translates to:
  /// **'2. Register New Account'**
  String get hw_mc_2;

  /// No description provided for @hw_mc_3.
  ///
  /// In en, this message translates to:
  /// **'3. Create New Profile'**
  String get hw_mc_3;

  /// No description provided for @hw_mc_4.
  ///
  /// In en, this message translates to:
  /// **'4. Choose Services'**
  String get hw_mc_4;

  /// No description provided for @hw_mc_5.
  ///
  /// In en, this message translates to:
  /// **'5. Payments'**
  String get hw_mc_5;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @open_google_map.
  ///
  /// In en, this message translates to:
  /// **'Open Google Map'**
  String get open_google_map;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @thawani_payment.
  ///
  /// In en, this message translates to:
  /// **'Thawani Payment'**
  String get thawani_payment;

  /// No description provided for @no_ser.
  ///
  /// In en, this message translates to:
  /// **'No service men available'**
  String get no_ser;

  /// No description provided for @no_ava.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get no_ava;

  /// No description provided for @how.
  ///
  /// In en, this message translates to:
  /// **'Getting Started: Understanding the Process'**
  String get how;

  /// No description provided for @how1.
  ///
  /// In en, this message translates to:
  /// **'Sign Up and Get Started'**
  String get how1;

  /// No description provided for @how1s.
  ///
  /// In en, this message translates to:
  /// **'Creating an account in TUWService app very simple by using Registered mobile number .The user visits the application\'s registration page and provide  phone number. The platform generates a one-time password and sends it to the user\'s registered mobile number or email address. The OTP is usually valid for a short period, typically a few minutes. They then enter this code into the provided field on the registration page.The platform validates the OTP entered by the user against the OTP it generated. If the code matches, the platform confirms that the user has access to the registered contact information. With successful verification of the OTP, the platform proceeds to create the user\'s account, storing the provided details in its database.'**
  String get how1s;

  /// No description provided for @how2.
  ///
  /// In en, this message translates to:
  /// **'What We Get From TUW Services Application'**
  String get how2;

  /// No description provided for @how2s.
  ///
  /// In en, this message translates to:
  /// **'TUW Service App Provides you one-stop solution for seamless and hassle-free service bookings. Whether you need to book a ac repair, schedule a home repair, or arrange for a labor recruitment, our app is designed to simplify your life and provide you with the best service providers at your fingertips. Here\'s what you can expect from our Service Booking App:A Vast Range of Services: We\'ve partnered with a diverse array of trusted service providers toVerified and Reliable Providers: Rest assured that all the service providers on our platform undergo a rigorous verification process. Easy Booking Process: Booking a service is a breeze with our app. Simply browse through the list of services, select your preferred provider, choose a suitable time, and confirm your booking - all in just a few taps.'**
  String get how2s;

  /// No description provided for @how3.
  ///
  /// In en, this message translates to:
  /// **'Is it possible to register as a serviceman'**
  String get how3;

  /// No description provided for @how3s.
  ///
  /// In en, this message translates to:
  /// **'Yes, absolutely! Our platform welcomes servicemen who are looking to offer their services to our esteemed customers. Whether you are a skilled professional, tradesperson, or provide any form of service, we encourage you to register and join our network of service providers.'**
  String get how3s;

  /// No description provided for @how4.
  ///
  /// In en, this message translates to:
  /// **'How to become a serviceman'**
  String get how4;

  /// No description provided for @how4s.
  ///
  /// In en, this message translates to:
  /// **'Becoming a serviceman is a rewarding journey that allows you to use your skills and expertise to help others and make a positive impact. Whether you are interested in providing home services, professional trades, or specialized expertise, here\'s a step-by-step guide on how to become a serviceman: Identify Your Skills and Passion: Determine your area of expertise and passion. Reflect on your skills, knowledge, and the services you can confidently offer to customers. It could be anything from plumbing, electrical work, carpentry, tutoring, personal training, beauty services, or any other service that aligns with your abilities and interests. Sign upinto the system - You can create an account in TUW simply and easily by using your registered phone number. Once you are part of TUW you can convert your account to a service man. Secure Payment - There will be a subscription charges for expose your skills. you can choose the area of you are experienced and register in it. Verification - There will be a verification process which will ensure your genuinity and which will help us a string trusted community'**
  String get how4s;

  /// No description provided for @how5.
  ///
  /// In en, this message translates to:
  /// **'Is it possible to delete my account'**
  String get how5;

  /// No description provided for @how5s.
  ///
  /// In en, this message translates to:
  /// **'Yes, absolutely! We understand that circumstances change, and you may wish to delete your account for various reasons. Deleting your account is a straightforward process, and we are here to assist you with it. Here\'s a guide on how to delete your account: Login to Your Account: First, log in to your account using your credentials Find the Delete Account Option: Look for the \'Delete Account\' or \'Close Account\' option within the settings. Confirmation: After reviewing the details, the platform will likely ask you to confirm your decision to delete the account. This is to ensure that you don\'t accidentally delete your account.'**
  String get how5s;

  /// No description provided for @waiting_for_admin_apporval.
  ///
  /// In en, this message translates to:
  /// **'Success, waiting for admin approval'**
  String get waiting_for_admin_apporval;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
