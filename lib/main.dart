import 'package:flutter/material.dart';

void main() {
  runApp(BookManagementApp());
}

class BookManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple, // Updated to Purple Theme
      ),
      home: BookListScreen(),
    );
  }
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final TextEditingController _bookController = TextEditingController();
  List<String> _books = [];

  void _addBook() {
    String bookTitle = _bookController.text.trim();
    if (bookTitle.isNotEmpty) {
      setState(() {
        _books.insert(0, bookTitle);
        _bookController.clear();
      });
    }
  }

  void _removeBook(int index) {
    setState(() {
      _books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Curved AppBar
          ClipPath(
            clipper: CustomAppBarClipper(),
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade800, Colors.purple.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  "Book Management",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _bookController,
                    decoration: InputDecoration(
                      labelText: "Enter Book Title",
                      labelStyle: TextStyle(fontSize: 16, color: Colors.purple.shade800),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.purple.shade50, // Light Purple Background
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade700,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Add Book",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: _books.isEmpty
                        ? Center(
                            child: Text(
                              "No books added yet.",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _books.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.purple.shade50, // Light purple cards
                                child: ListTile(
                                  title: Text(
                                    _books[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.purple.shade900, // Dark Purple Text
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.redAccent),
                                    onPressed: () => _removeBook(index),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for Curved AppBar
class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


