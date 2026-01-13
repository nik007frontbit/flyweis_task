# Flyweis Task App - Mr Amani Social

A Flutter application built with **GetX** and **MVC Architecture** that serves as a social media platform featuring Reels, Stories, and User Profiles. This project integrates with the "Mr Amani Backend" API.

## 🚀 Features

*   **Authentication**: OTP-based Login, Signup (User creation on verification), and Logout.
*   **Dashboard**: Tab-based navigation between Home (Reels), Stories, and Profile.
*   **Reels (Feed)**:
    *   View list of reels/posts.
    *   Create, Update, and Delete reels.
    *   **Like & Comment**: Interact with reels.
    *   **Share**: Share reels (APIs integrated).
*   **Stories**:
    *   Dedicated tab for stories.
    *   View, Create, Update, and Delete stories.
*   **Profile**: View user details and manage session.
*   **Comments**: View and add comments on reels via a bottom sheet.

## 🛠 Tech Stack

*   **Framework**: Flutter
*   **State Management**: GetX
*   **Architecture**: MVC (Model-View-Controller)
*   **Networking**: `http` package with a centralized `HttpHandler`.
*   **Local Storage**: `get_storage` (for token and user session).
*   **Image Caching**: `cached_network_image`.

## 📂 Project Structure

```
lib/
├── config/             # App configuration (Colors, Strings, Static data)
├── controller/         # GetX Controllers (Business Logic)
├── model/              # Data Models (JSON parsing)
├── utils/              # Utilities (HttpHandler, Helpers)
├── view/               # UI Screens (Views)
│   ├── auth/           # Login/Signup screens
│   ├── dashboard/      # Main Dashboard & Navigation
│   ├── profile/        # Profile screen
│   ├── reel/           # Reel Feed & Create Reel screens
│   ├── story/          # Story Feed & Create Story screens
│   └── comment/        # Comment widgets
└── widget/             # Reusable widgets (Buttons, TextFields, etc.)
```

## 🔌 API Integration

This project integrates over **15 APIs** from the backend.

### Authentication
*   `POST` **Login (Send OTP)**: `api/v2/authentication/userLogin`
*   `POST` **Verify OTP**: `api/v2/authentication/verify_otp`

### User Profile
*   `GET` **Get Profile**: `api/v2/user/getbyAuthProfile`

### Reels (Posts)
*   `POST` **Create Reel**: `api/v2/Reel/create`
*   `GET` **Get All Reels**: `api/v2/Reel/getAll`
*   `PUT` **Update Reel**: `api/v2/Reel/update/:id`
*   `DELETE` **Delete Reel**: `api/v2/Reel/delete/:id`

### Reel Shares
*   `POST` **Share Reel**: `api/v2/Reel_share/create`
*   `GET` **Get All Shares**: `api/v2/Reel_share/getAll`
*   `DELETE` **Delete Share**: `api/v2/Reel_share/delete/:id`

### Stories
*   `POST` **Create Story**: `api/v2/Story/create`
*   `GET` **Get All Stories**: `api/v2/Story/getAll`
*   `PUT` **Update Story**: `api/v2/Story/update/:id`
*   `DELETE` **Delete Story**: `api/v2/Story/delete/:id`

### Comments
*   `POST` **Create Comment**: `api/v2/Reel_Comment/create`
*   `GET` **Get Comments**: `api/v2/Reel_Comment/getByReelId/:id`
*   `DELETE` **Delete Comment**: `api/v2/Reel_Comment/delete/:id`

## ⚙️ Setup & Run

1.  **Clone the repository**.
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```

## 📝 Key Implementation Details

*   **HttpHandler**: A robust, centralized network handler (`lib/utils/http_handler/network_http.dart`) that manages:
    *   Authorization headers (Bearer Token).
    *   Loading indicators (`onResponseLoaderClose`).
    *   Global error handling (Snackbars).
    *   Auto-logout on 401 Unauthorized.
*   **CommonNetworkImage**: Uses `CachedNetworkImage` for efficient image loading with placeholders.
*   **App Lifecycle**: `SplashScreen` checks for a valid token in `GetStorage` to auto-login.

---
**Developed for Flyweis Task.**
