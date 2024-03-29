class Category {
  final String categoryTitle;
  final String categoryLink;
  final String iconLink;
  final String oldDate;
  final String newDate;
  final String updated;

  Category(
      {required this.categoryTitle,
        required this.categoryLink,
        this.iconLink = '',
        required this.oldDate,
        required this.newDate,
        required this.updated});
}
