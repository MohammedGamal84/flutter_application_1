import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'app_name': 'السياحة',
      'discover_fayoum': 'اكتشف الفيوم',
      'tourist_guide': 'دليلك السياحي',
      'tourist_places': 'الأماكن السياحية',
      'explore_best_places': 'استكشف أجمل المعالم السياحية',
      'all': 'الكل',
      'nature': 'طبيعة',
      'history': 'تاريخ',
      'adventure': 'مغامرة',
      'full_day': 'يوم كامل',
      'more': 'المزيد',
      'no_places': 'لا توجد أماكن متاحة',
      'my_account': 'حسابي',
      'hotels': 'فنادق',
      'map': 'خريطة',
      'places': 'أماكن',
      'home': 'الرئيسية',
      'about_place': 'نبذة عن المكان',
      'top_features': 'أبرز المميزات',
      'location': 'الموقع',
      'price': 'السعر',
      'duration': 'المدة',
      'book_now': 'احجز الآن',
      'no_data': 'لا توجد بيانات',
      'error': 'حدث خطأ',
      'change_language': 'تغيير اللغة',
      'arabic': 'العربية',
      'english': 'English',

      'login': 'تسجيل الدخول',
      'signup': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'enter_email': 'أدخل بريدك الإلكتروني',
      'password': 'كلمة المرور',
      'enter_password': 'أدخل كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'reenter_password': 'أعد إدخال كلمة المرور',
      'your_name': 'ادخل اسمك',
      'enter_full_name': 'أدخل اسمك الكامل',
      'forgot_password': 'نسيت كلمة المرور؟',
      'login_success': 'تم تسجيل الدخول بنجاح',
      'signup_success': 'تم إنشاء الحساب بنجاح',
      'create_new_account': 'إنشاء حساب جديد',
      'terms_text':
          'بالمتابعة أنت توافق على الشروط والأحكام وسياسة الخصوصية',
      'email_required': 'البريد الإلكتروني مطلوب',
      'invalid_email': 'البريد الإلكتروني غير صحيح',
      'password_required': 'كلمة المرور مطلوبة',
      'password_short': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
      'name_required': 'الاسم مطلوب',
      'confirm_password_required': 'تأكيد كلمة المرور مطلوب',
      'passwords_not_match': 'كلمة المرور غير متطابقة',

      'skip': 'تخطي',
      'next': 'التالي',
      'start_now': 'ابدأ الآن',
      'onboarding_title_1': 'اكتشف الفيوم',
      'onboarding_subtitle_1':
          'استمتع بجمال الطبيعة والآثار الفريدة في الفيوم، واكتشف أماكن ساحرة وتجارب لا تُنسى',
      'onboarding_title_2': 'استكشف المعالم',
      'onboarding_subtitle_2':
          'تعرّف على أشهر المعالم السياحية والأثرية والوجهات المميزة داخل الفيوم بسهولة',
      'onboarding_title_3': 'خطط رحلتك',
      'onboarding_subtitle_3':
          'نظّم زيارتك واحفظ الأماكن المفضلة لديك للوصول إلى تجربة أفضل',
      'onboarding_title_4': 'ابدأ المغامرة',
      'onboarding_subtitle_4':
          'ابدأ الآن واستمتع بتجربة سياحية متكاملة داخل الفيوم',
      // ar
'forgot_password_title': 'نسيت كلمة المرور',
'forgot_password_subtitle': 'أدخل بريدك الإلكتروني لإرسال كود إعادة تعيين كلمة المرور',
'recover_password': 'استعادة كلمة المرور',
'send_code': 'إرسال الكود',
'reset_password_title': 'تغيير كلمة المرور',
'reset_password_header': 'إعادة تعيين كلمة المرور',
'reset_code': 'الكود',
'enter_reset_code': 'أدخل الكود المرسل',
'new_password': 'كلمة المرور الجديدة',
'enter_new_password': 'أدخل كلمة المرور الجديدة',
'confirm_new_password': 'تأكيد كلمة المرور',
'reenter_new_password': 'أعد إدخال كلمة المرور الجديدة',
'code_required': 'الكود مطلوب',
'new_password_required': 'كلمة المرور الجديدة مطلوبة',
'reset_password_success': 'تم تغيير كلمة المرور بنجاح',
'forgot_password_success': 'تم إرسال كود إعادة تعيين كلمة المرور',
'email_label_with_value': 'البريد الإلكتروني: ',
'start_adventure': 'ابدأ المغامرة',    
'splash_title': 'اكتشف الفيوم',
'splash_subtitle': 'رحلة إلى جمال الطبيعة',
   
    },

    'en': {
      'app_name': 'Tourism',
      'discover_fayoum': 'Discover Fayoum',
      'tourist_guide': 'Your Travel Guide',
      'tourist_places': 'Tourist Places',
      'explore_best_places': 'Explore the best tourist attractions',
      'all': 'All',
      'nature': 'Nature',
      'history': 'History',
      'adventure': 'Adventure',
      'full_day': 'Full Day',
      'more': 'More',
      'no_places': 'No places available',
      'my_account': 'My Account',
      'hotels': 'Hotels',
      'map': 'Map',
      'places': 'Places',
      'home': 'Home',
      'about_place': 'About the Place',
      'top_features': 'Top Features',
      'location': 'Location',
      'price': 'Price',
      'duration': 'Duration',
      'book_now': 'Book Now',
      'no_data': 'No data available',
      'error': 'An error occurred',
      'change_language': 'Change Language',
      'arabic': 'العربية',
      'english': 'English',

      'login': 'Login',
      'signup': 'Sign Up',
      'email': 'Email',
      'enter_email': 'Enter your email',
      'password': 'Password',
      'enter_password': 'Enter your password',
      'confirm_password': 'Confirm Password',
      'reenter_password': 'Re-enter your password',
      'your_name': 'Your Name',
      'enter_full_name': 'Enter your full name',
      'forgot_password': 'Forgot password?',
      'login_success': 'Login successful',
      'signup_success': 'Account created successfully',
      'create_new_account': 'Create New Account',
      'terms_text':
          'By continuing, you agree to the Terms and Conditions and Privacy Policy',
      'email_required': 'Email is required',
      'invalid_email': 'Invalid email',
      'password_required': 'Password is required',
      'password_short': 'Password must be at least 6 characters',
      'name_required': 'Name is required',
      'confirm_password_required': 'Confirm password is required',
      'passwords_not_match': 'Passwords do not match',

      'skip': 'Skip',
      'next': 'Next',
      'start_now': 'Start Now',
      'onboarding_title_1': 'Discover Fayoum',
      'onboarding_subtitle_1':
          'Enjoy the beauty of nature and unique monuments in Fayoum, and discover magical places and unforgettable experiences',
      'onboarding_title_2': 'Explore Attractions',
      'onboarding_subtitle_2':
          'Learn about the most famous tourist and historical landmarks and special destinations in Fayoum easily',
      'onboarding_title_3': 'Plan Your Trip',
      'onboarding_subtitle_3':
          'Organize your visit and save your favorite places for a better experience',
      'onboarding_title_4': 'Start the Adventure',
      'onboarding_subtitle_4':
          'Start now and enjoy a complete tourism experience in Fayoum',
// en
'forgot_password_title': 'Forgot Password',
'forgot_password_subtitle': 'Enter your email to receive a password reset code',
'recover_password': 'Recover Password',
'send_code': 'Send Code',
'reset_password_title': 'Change Password',
'reset_password_header': 'Reset Password',
'reset_code': 'Code',
'enter_reset_code': 'Enter the code sent',
'new_password': 'New Password',
'enter_new_password': 'Enter the new password',
'confirm_new_password': 'Confirm New Password',
'reenter_new_password': 'Re-enter the new password',
'code_required': 'Code is required',
'new_password_required': 'New password is required',
'reset_password_success': 'Password changed successfully',
'forgot_password_success': 'Password reset code has been sent',
'email_label_with_value': 'Email: ',
'start_adventure': 'Start the Adventure',
'splash_title': 'Discover Fayoum',
'splash_subtitle': 'A journey to the beauty of nature',
      
      
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}