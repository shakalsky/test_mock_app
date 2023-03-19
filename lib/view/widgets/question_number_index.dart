import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionNumberIndex extends StatelessWidget {
  final int questionNumber;

  const QuestionNumberIndex({
    Key? key,
    required this.questionNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          margin: const EdgeInsets.only(left: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(1, 5.0),
                blurRadius: 1.5,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(2, 1),
                blurRadius: 0,
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: Text(
              '$questionNumber / 10',
              style: GoogleFonts.mulish(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
