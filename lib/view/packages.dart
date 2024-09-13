import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme/app_colors.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Packages Screen',
        style: GoogleFonts.alegreyaSans(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBlueColor,
        ),
      ),
    );
  }
}
