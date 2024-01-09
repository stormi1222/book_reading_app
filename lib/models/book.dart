class Book {
  final String id;
  final String rank;
  final String title;
  final String subtitle;
  final String thumbnailUrl;
  final List<String> authors;
  final String singleAuthor;
  final String previewLink;
  final String infoLink;
  final String isbn;
  final String buyLink;
  final List<String> categories;
  final String description;
  final String publisher;
  final String publishedDate;
  final String averageRating;
  final String webReaderLink;
  final int pageCount;
  final bool isEbook;
  final String saleability;
  final String amount;
  final String currencyCode;
  final String accessViewStatus;

  Book({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.publishedDate,
    required this.authors,
    required this.publisher,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.averageRating,
    required this.thumbnailUrl,
    required this.previewLink,
    required this.infoLink,
    required this.buyLink,
    required this.webReaderLink,
    required this.isEbook,
    required this.saleability,
    required this.amount,
    required this.currencyCode,
    required this.accessViewStatus,
    required this.isbn,
    required this.rank,
    required this.singleAuthor,
  });
}