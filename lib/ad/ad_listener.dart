typedef AdEventCallback<Ad> = void Function(Ad ad);

class AdListener {
  AdListener(
      {this.onLoadedFailed,
      this.onImpression,
      this.onClick,
      this.onClose,
      this.onLoaded});
  final AdEventCallback? onLoaded;
  final AdEventCallback? onLoadedFailed;
  final AdEventCallback? onImpression;
  final AdEventCallback? onClick;
  final AdEventCallback? onClose;
}
