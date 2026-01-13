class APIString {
  APIString._();

  // Base URL
  // Base URL
  static const String baseURL = "https://amani-backend.vercel.app/";
  
  // Auth
  static const String sendOtp = "api/v2/authentication/userLogin";
  static const String verifyOtp = "api/v2/authentication/verify_otp";
  
  // Profile
  static const String getProfile = "api/v2/user/getbyAuthProfile";
  
  // Reels
  static const String createReel = "api/v2/Reel/create";
  static const String getAllReels = "api/v2/Reel/getAll";
  static const String getReelById = "api/v2/Reel/getById"; // append /:id
  static const String updateReel = "api/v2/Reel/update"; // append /:id
  static const String deleteReel = "api/v2/Reel/delete"; // append /:id

  // Reel Share
  static const String createReelShare = "api/v2/Reel_share/create";
  static const String getAllReelShares = "api/v2/Reel_share/getAll";
  static const String deleteReelShare = "api/v2/Reel_share/delete"; // append /:id

  // Story
  static const String createStory = "api/v2/Story/create";
  static const String getAllStories = "api/v2/Story/getAll"; // ?page=1&limit=10&status=true
  static const String getStoryById = "api/v2/Story/getById"; // append /:id
  static const String updateStory = "api/v2/Story/update"; // append /:id
  static const String deleteStory = "api/v2/Story/delete"; // append /:id

  // Comment
  static const String createComment = "api/v2/Reel_Comment/create";
  static const String getCommentsByReelId = "api/v2/Reel_Comment/getByReelId"; // append /:realPostId
  static const String deleteComment = "api/v2/Reel_Comment/delete"; // append /:id
  
}
