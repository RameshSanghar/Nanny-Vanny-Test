import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme/app_colors.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bookings Screen',
        style: GoogleFonts.alegreyaSans(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBlueColor,
        ),
      ),
    );
  }
}
