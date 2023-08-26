class SnapHeight {
  /// height in percentage, should be between 0 and 1
  double height;

  ///minHeight in pixel
  double? minHeight;

  ///maxHeight in pixel
  double? maxHeight;

  SnapHeight(this.height, {this.minHeight, this.maxHeight});
}
