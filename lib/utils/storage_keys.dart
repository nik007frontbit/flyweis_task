/// Storage keys constants for GetStorage
class StorageKeys {
  // Private constructor to prevent instantiation
  StorageKeys._();
  
  // Chat related keys
  static const String harrisonsChatHistory = 'harrison_chat_history';
  static const String chatLastUpdated = 'chat_last_updated';
  
  // User preferences
  static const String userPreferences = 'user_preferences';
  static const String themeMode = 'theme_mode';
  
  // Auth related
  static const String isLoggedIn = 'is_logged_in';
  static const String userEmail = 'user_email';
  static const String lastLoginTime = 'last_login_time';
  
  // Question bank filters
  static const String lastSelectedYear = 'last_selected_year';
  static const String lastSelectedMonth = 'last_selected_month';
  static const String lastSelectedSection = 'last_selected_section';
  static const String lastSelectedChapter = 'last_selected_chapter';
}
