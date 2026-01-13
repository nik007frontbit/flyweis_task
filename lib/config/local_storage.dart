class LocalStorageData {
  LocalStorageData._();

  // DATA TYPE
  static const String boolType = "BOOL";
  static const String doubleType = "DOUBLE";
  static const String integerType = "INTEGER";
  static const String stringType = "STRING";
  static const String listOfStringType = "LIST-OF-STRING";

  // 🔐 AUTH & TOKEN
  static const String token = "token";
  static const String accessToken = "access_token";
  static const String refreshToken = "refresh_token";
  static const String fcmToken = "fcm_token";

  // 👤 USER INFO
  static const String userId = "user_id";
  static const String chemistId = "chemist_id";
  static const String loginParentId = "login_parent_id";
  static const String userName = "user_name";
  static const String userEmail = "user_email";
  static const String userPhone = "user_phone";
  static const String profilePicture = "profile_picture";
  static const String userRole = "user_role";

  // 📱 DEVICE INFO
  static const String deviceId = "device_id";
  static const String deviceModel = "device_model";
  static const String deviceOs = "device_os";
  static const String deviceManufacturer = "device_manufacturer";
  static const String deviceSdkVersion = "device_sdk_version";
  static const String appVersion = "app_version";
  static const String platform = "platform";

  // ⚙️ APP SETTINGS
  static const String onBoarding = "onBoarding";
  static const String rememberMe = "remember_me";
  static const String language = "language";
  static const String themeMode = "theme_mode"; // light / dark
  static const String notificationsEnabled = "notifications_enabled";
  static const String autoLogin = "auto_login";
  static const String lastLoginTime = "last_login_time";

  // 🔒 SECURITY
  static const String appPassword = "app_password";
  static const String biometricEnabled = "biometric_enabled";
  static const String gameLockEnabled = "game_lock_enabled";
  static const String sessionTimeout = "session_timeout";

  // 🏢 BUSINESS / APP DATA
  static const String businessName = "business_name";
  static const String businessAddress = "business_address";
  static const String businessStartHour = "business_start_hour";
  static const String businessStartMinute = "business_start_minute";
  static const String businessEndHour = "business_end_hour";
  static const String businessEndMinute = "business_end_minute";

  //subscription
  static const String planSubscription = "plan_subscription";
  static const String planExpireDate = "plan_expire_date";
  static const String planTrialOn = "plan_trial_on";
  static const String planStatusOn = "plan_status_on";

  // 🧩 MISC
  static const String terms = "terms";
  static const String email = "email";
  static const String password = "password";
  static const String lastSyncTime = "last_sync_time";
  static const String tempData = "temp_data";
  static const String cacheVersion = "cache_version";

  static const String currentOrder = "current_order";
  static const String savedDrafts = "saved_drafts";
  static const String draftListSelectedTab = 'draft_list_selected_tab';
}
