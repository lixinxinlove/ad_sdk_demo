enum AdType {
  native(5),
  intertitial(1),
  banner(0),
  open(3),
  reward(4);

  final int code;
  const AdType(this.code);
}

enum AdPlatform {
  admob(0),
  facebook(1),
  ironsource(3),
  pangle(4),
  chartboost(5),
  applovin(7),
  topon(9),
  max(12),
  tradplus(13);

  final int code;
  const AdPlatform(this.code);
}

enum AdEvent {
  request(0),
  loadFailed(1),
  loadSuccess(2),
  impression(3),
  click(4);

  final int code;
  const AdEvent(this.code);
}