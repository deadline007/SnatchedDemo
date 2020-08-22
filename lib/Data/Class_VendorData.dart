class ClassVendorData {
  final String name;
  final bool onlineStatus;
  final location;
  final int phone;
  final String vid;
  final double stars;
  final String type;
  String vendorBannerPath;
  String vendorProfileImage;

  ClassVendorData(
      {this.location,
      this.type,
      this.name,
      this.onlineStatus,
      this.phone,
      this.vid,
      this.stars});
}
