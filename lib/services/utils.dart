import 'package:book_reading_app/models/book.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String listToString(List<String> list, String seperator) {
    String generatedString = '';
    if (list == null) {
      return '---';
    } else {
      list.forEach((element) {
        generatedString += element + seperator;
      });
      return generatedString;
    }
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String trimString(String strToTrim, [int trimLimit = 40]) {
    if (strToTrim.length > trimLimit) {
      return '${strToTrim.substring(0, trimLimit)}...';
    }
    return strToTrim;
  }

  static Book bookFromJson(Map book) {
    var volumeInfo = book['volumeInfo'];
    var saleInfo = book['saleInfo'];
    var accessInfo = book['accessInfo'];
    var identifiers = volumeInfo['industryIdentifiers'];

    // Extracting values from JSON
    String isbn = identifiers != null && identifiers.isNotEmpty
        ? identifiers[0]['identifier']
        : 'Unknown ISBN';

    String rank = volumeInfo['rank'] ?? 'Unknown Rank';

    String singleAuthor = volumeInfo['authors'] != null &&
        (volumeInfo['authors'] as List).length == 1
        ? volumeInfo['authors'][0]
        : 'Unknown Author';

    return Book(
      id: book['id'],
      title: volumeInfo['title'],
      subtitle: volumeInfo['subtitle'],
      publishedDate: volumeInfo['publishedDate'] ?? '---',
      authors: volumeInfo['authors'] != null
          ? (volumeInfo['authors'] as List<dynamic>)
          .map((author) => author.toString())
          .toList()
          : [''],
      publisher: volumeInfo['publisher'] ?? '---',
      description: volumeInfo['description'] ?? 'No description available.',
      pageCount: volumeInfo['pageCount'],
      categories: volumeInfo['categories'] != null
          ? (volumeInfo['categories'] as List<dynamic>)
          .map((category) => category.toString())
          .toList()
          : [],
      averageRating: volumeInfo['averageRating'] ?? '---',
      thumbnailUrl: volumeInfo['imageLinks'] != null
          ? '${volumeInfo['imageLinks']['thumbnail']}'
          : 'https://www.wildhareboca.com/wp-content/uploads/sites/310/2018/03/image-not-available.jpg',
      previewLink: volumeInfo['previewLink'],
      infoLink: volumeInfo['infoLink'],
      buyLink: saleInfo['buyLink'],
      webReaderLink: accessInfo['webReaderLink'],
      isEbook: saleInfo['isEbook'],
      saleability: saleInfo['saleability'],
      amount: saleInfo['saleability'] == 'FOR_SALE'
          ? saleInfo['retailPrice']['amount'].toString()
          : '---',
      currencyCode: saleInfo['saleability'] == 'FOR_SALE'
          ? saleInfo['retailPrice']['currencyCode']
          : '---',
      accessViewStatus: accessInfo['accessViewStatus'],
      isbn: isbn,
      rank: rank,
      singleAuthor: singleAuthor,
    );
  }
}
