class Picture {
  final String imagePath;

  const Picture({
    required this.imagePath,
});
  Picture copy({
  String? imagePath,
}) => Picture(
    imagePath: imagePath ?? this.imagePath
  );
  static Picture fromJson(Map<String, dynamic> json) => Picture(
    imagePath: json['imagePath'],
  );
  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
  };
}