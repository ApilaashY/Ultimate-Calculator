import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

int _loadOrSkip = 0;

void showinter() {
  if (_loadOrSkip == 0) {
    String id = '';
    if (defaultTargetPlatform == TargetPlatform.android) {
      id = 'ca-app-pub-4914732861439858/4723689009';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      id = 'ca-app-pub-4914732861439858/8604591248';
    }
    InterstitialAd.load(
      adUnitId: id,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (er) {
          throw er;
        },
      ),
    );
  } else if (_loadOrSkip == 5) {
    _loadOrSkip = 0;
  }
  _loadOrSkip++;
}
