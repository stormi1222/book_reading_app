import 'package:book_reading_app/models/savedBook.dart';
import 'package:book_reading_app/providers/bookshelf.dart';
import 'package:book_reading_app/screens/book_detail_screen.dart';
import 'package:book_reading_app/services/book_search_utils.dart';
import 'package:book_reading_app/services/utils.dart';
import 'package:book_reading_app/widgets/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SavedBookItem extends StatefulWidget {
  final SavedBook savedBook;

  SavedBookItem(this.savedBook);

  @override
  _SavedBookItemState createState() => _SavedBookItemState();
}

class _SavedBookItemState extends State<SavedBookItem> {
  var searchedBook;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((_) async {
      searchedBook = await BookSearchUtils.fetchBookById(widget.savedBook.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showModalBottomSheet(
            elevation: 18.0,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return FutureBuilder(
                future: BookSearchUtils.fetchBookById(widget.savedBook.id),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? LinearProgressIndicator()
                      : BookDetailBottomSheet(searchedBook);
                },
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: Dismissible(
          key: ValueKey(widget.savedBook.id),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            await Provider.of<Bookshelf>(context, listen: false)
                .removeSavedBook(widget.savedBook.id);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.height * 0.11,
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                            child: NetworkSensitive(
                              offlineChild: Center(
                                  child: Text(
                                    'NO INTERNET CONNECTION',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 8.0),
                                  )),
                              child: Image.network(
                                widget.savedBook.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))),
                  SizedBox(width: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.savedBook.authors,
                            style: TextStyle(color: Colors.teal, fontSize: 10),
                          ),
                          SizedBox(height: 4),
                          Text(
                            Utils.trimString(widget.savedBook.title, 50),
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
