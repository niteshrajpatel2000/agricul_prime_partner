import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

final appUpdateProvider = StateNotifierProvider<UpdateNotifier, bool>((ref) {
  return UpdateNotifier();
});

class UpdateNotifier extends StateNotifier<bool> {
  UpdateNotifier() : super(false);

  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate(BuildContext context) async {
    try {
      _updateInfo = await InAppUpdate.checkForUpdate();

      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        _redirectToPlayStore();
      }
    } catch (e) {
      debugPrint("Error checking update: $e");
    }
  }

  /// 👉 Direct Redirect to Play Store
  Future<void> _redirectToPlayStore() async {
    const packageName = "agricul.prime.partner";
    final Uri url = Uri.parse(
        "https://play.google.com/store/apps/details?id=$packageName");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
