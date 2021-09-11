import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';
  InterstitialAd? _interstitialAd;
  int num_load = 0;

  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd getBannerAd() {
    BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(onAdLoaded: (Ad ad) {
          print("ad loaded");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print("ad Failed loaded");
          ad.dispose();
        }, onAdOpened: (Ad ad) {
          print("ad Open");
        }),
        request: AdRequest());
    return bannerAd;
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/8691691433',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              _interstitialAd = ad;
              num_load = 0;
            },
            onAdFailedToLoad: (LoadAdError erroe) {

              num_load +1;
              _interstitialAd=null;
              if(num_load<=2){
                createInterstitialAd();
              }

            }));
  }

  void showInterstitialAd() {

        if(_interstitialAd==null){
          return;
        }
        _interstitialAd!.fullScreenContentCallback=FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad){
             print("ad InterstitialAd fullScreen");
          },
          onAdDismissedFullScreenContent: (InterstitialAd ad){
              ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
            print('$ad Failed $error');
            ad.dispose();
            createInterstitialAd();

          }

        );
          _interstitialAd!.show();
          _interstitialAd=null;


  }
}
