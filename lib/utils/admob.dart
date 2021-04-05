import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1214689406608334~2048198162";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;

  final String _bannerAd = Platform.isAndroid
      ? 'ca-app-pub-1214689406608334/5129834684'
      : 'ca-app-pub-1214689406608334/5129834684';

//  final String _gecisAd = Platform.isAndroid ? 'xx' : 'xx';

  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showBanner() {
    BannerAd banner = BannerAd(
        //adUnitId: BannerAd.testAdUnitId,
        adUnitId: _bannerAd,
        size: AdSize.smartBanner,
        targetingInfo: _targetingInfo);
    banner
      ..load()
      ..show()
      ..show(anchorOffset: 50);
    banner.dispose();
  }

/*
  showIntersitial() {
    InterstitialAd interstitialAd = InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        //adUnitId: _gecisAd,
        targetingInfo: _targetingInfo);

    interstitialAd
      ..load()
      ..show();
    interstitialAd.dispose();
  }*/
}
