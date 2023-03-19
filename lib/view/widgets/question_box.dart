import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionBox extends StatelessWidget {
  final String question;
  const QuestionBox({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, right: 16.0, left: 16.0),
      child: Text(
        question,
        textAlign: TextAlign.justify,
        style: GoogleFonts.mulish(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}
