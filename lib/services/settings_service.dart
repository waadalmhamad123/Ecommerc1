class SettingsService {
  bool notificationsEnabled = true;

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
  }

  void logout() {}
}
