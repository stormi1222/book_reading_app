import 'package:book_reading_app/models/book.dart';
import 'package:book_reading_app/services/utils.dart';
import 'package:book_reading_app/widgets/showcaseWidgets/showcase_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowcaseBookItem extends StatelessWidget {
  final Book book;

  ShowcaseBookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            elevation: 18.0,
            context: context,
            builder: (context) {
              return ShowcaseSearchBottomSheet(book);
            });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                elevation: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: FadeInImage.memoryNetwork(
                    image: book.thumbnailUrl,
                    placeholder: kTransparentImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              Utils.trimString(book.singleAuthor, 15),
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            Expanded(
              child: Text(
                Utils.trimString(book.title, 15),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        height: 1)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
