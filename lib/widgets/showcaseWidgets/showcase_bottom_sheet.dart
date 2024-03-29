import 'package:book_reading_app/models/book.dart';
import 'package:book_reading_app/screens/specific_search_screen.dart';
import 'package:book_reading_app/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowcaseSearchBottomSheet extends StatelessWidget {
  final Book book;

  ShowcaseSearchBottomSheet(this.book);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff737373).withOpacity(0),
      child: Container(
        padding: EdgeInsets.all(30),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: Container(
                            color: Colors.lightBlueAccent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 2.0),
                              child: Text(
                                '#${book.rank}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          book.singleAuthor,
                          style: TextStyle(fontSize: 12.0, color: Colors.teal),
                        ),
                        SizedBox(height: 5),
                        Text(
                          book.title,
                          softWrap: true,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.height * 0.15,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            SpecificSearchScreen.routeName,
                            arguments: {
                              'bookTitle': book.title,
                              'bookAuthor': book.singleAuthor
                            });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.thumbnailUrl,
//                  height: kBookImageHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'DESCRIPTION',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Text(
                          book.description == ''
                              ? 'Not Available'
                              : book.description,
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                letterSpacing: 0.2,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Publisher : ',
                      softWrap: true,
                      style: TextStyle(color: Colors.teal),
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        Utils.trimString(book.publisher, 35),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Utils.launchURL(book.buyLink);
                      },
                      child: SizedBox(
                        child: Image.asset('images/amazonicon.png'),
                        height: 32,
                        width: 32,
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            SpecificSearchScreen.routeName,
                            arguments: {
                              'bookTitle': book.title,
                              'bookAuthor': book.singleAuthor
                            });
                      },
                      child: Icon(
                        Icons.search,
                        size: 28,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
