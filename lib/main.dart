import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

// Selected time save to locale

Future<void> saveTime(int m) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('selectedTime', m);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          body: Column(
            children: [
              Expanded(
                flex: 7,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: CupertinoPicker(
                      useMagnifier: true,
                      magnification: 1.2,
                      itemExtent: 80, // Her bir öğenin yüksekliği
                      onSelectedItemChanged: (int index) {
                        HapticFeedback.selectionClick();
                        _selectedIndex = 10 + index;
                        // Burada seçilen sayıyı bir değişkene atayabilirsin
                      },
                      children: List<Widget>.generate(51, (index) {
                        int output = 10 + index;
                        return Center(
                          child: Text(
                            "$output",
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFfca311),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              saveTime(_selectedIndex);
                            });
                          },
                          child: Text(
                            "Başlat",
                            style: GoogleFonts.zalandoSansExpanded(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
