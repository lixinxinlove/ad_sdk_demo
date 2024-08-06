import 'dart:io';

class Configuration {
  // static String appidStr = Platform.isIOS ? 'a5b0e8491845b3' : 'a5aa1f9deda26d';

  // static String appidkeyStr = Platform.isIOS
  //     ? '7eae0567827cfe2b22874061763f30c9'
  //     : '4f7b9ac17decb9babec83aac078742c7';

  // static bool inProduction = const bool.fromEnvironment("dart.vm.product");
  static bool inProduction = true;
  static String appidStr = Platform.isIOS
      ? inProduction
          ? 'a65604d41b0a16'
          : 'a62b40f5778f3d'
      : inProduction
          ? 'a6560507e75973'
          : 'a5aa1f9deda26d';

  static String appidkeyStr = Platform.isIOS
      ? inProduction
          ? 'af779eb150e7a9314b1f8f5c5586b00fa'
          : 'c3d0d2a9a9d451b07e62b509659f7c97'
      : inProduction
          ? 'a701ebf148e5fe60c52c3c7297174e07c'
          : '4f7b9ac17decb9babec83aac078742c7';

  static String rewarderPlacementID =
      Platform.isIOS ? 'b62b420baaefb0' : 'b5b449fb3d89d7';
  static String interstitialPlacementID =
      Platform.isIOS ? 'b62b41f0553690' : 'b5baca53984692';
  static String bannerPlacementID =
      Platform.isIOS ? 'b62b41f04bf88e' : 'b5baca4f74c3d8';
  static String nativePlacementID =
      Platform.isIOS ? 'b62b41c7781130' : 'b5aa1fa2cae775';

  static String rewarderSceneID = Platform.isIOS ? 'b62b420b7892f0' : '';

  static String nativeSceneID = Platform.isIOS ? 'f600938967feb5' : '';

  static String interstitialSceneID = Platform.isIOS ? 'f5e549727efc49' : '';

  static String bannerSceneID = Platform.isIOS ? 'f600938d045dd3' : '';
}
