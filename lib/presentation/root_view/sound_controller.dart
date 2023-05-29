import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

class SoundController extends GetxController {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  @override
  void onInit() {
    super.onInit();
    //playLaunchSoundtrack();
  }

  @override
  void onClose() {
    assetsAudioPlayer
        .dispose(); // Dispose the player when the controller is closed
    super.onClose();
  }

  void playClickSound() {
    assetsAudioPlayer.open(
      Audio('assets/sounds/sound_effects/click.mp3'),
    );
    assetsAudioPlayer.play();
  }

  void playLaunchSoundtrack() {
    assetsAudioPlayer.open(
      Audio('assets/sounds/themes/home_theme.mp3'),
    );
    assetsAudioPlayer.play();
  }
}
