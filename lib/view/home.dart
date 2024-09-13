import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme/app_colors.dart';
import '../controller/booking_controller.dart';
import '../controller/global_controller.dart';
import '../controller/package_controller.dart';
import '../model/current_booking_list_model.dart';
import '../model/package_list_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bookingController = Get.put<BookingController>(BookingController());
  final _packageController = Get.put<PackageController>(PackageController());
  final globalController = Get.find<GlobalController>();

  final List<String> _calendarImages = [
    "calender.svg",
    "calender3.svg",
    "calender5.svg",
    "calender7.svg",
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Future.wait([
      _bookingController.getCurrentBoookingList(),
      _packageController.getPackageList(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (controller) {
        return globalController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeSection(),
                      _buildNannyServiceCard(),
                      _buildCurrentBookingSection(),
                      _buildBookingList(),
                      _buildPackagesSection(),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryPinkColor,
            ),
            child: const Padding(
              padding: EdgeInsets.all(1.5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2017/08/26/11/18/model-2682792_1280.jpg",
                ),
              ),
            ),
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: GoogleFonts.alegreyaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightGreyColor,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "Emily Cyrus",
                  style: GoogleFonts.alegreyaSans(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryPinkColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNannyServiceCard() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.pinkBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(13)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Nanny And Babysitting Services",
                      style: GoogleFonts.alegreyaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlueColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Fluttertoast.showToast(
                        msg: "Book Nanny Service Tapped"),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlueColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                          child: Text(
                            "Book Now",
                            style: GoogleFonts.alegreyaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
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
        ),
        Image.asset("assets/img/nanny.png")
      ],
    );
  }

  Widget _buildCurrentBookingSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 35, bottom: 4),
      child: Text(
        "Your Current Booking",
        style: GoogleFonts.alegreyaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryBlueColor,
        ),
      ),
    );
  }

  Widget _buildBookingList() {
    return Column(
      children: List.generate(
        _bookingController.currentBookingListModel?.response.length ?? 0,
        (index) => _buildBookingCard(index),
      ),
    );
  }

  Widget _buildBookingCard(int index) {
    final booking = _bookingController.currentBookingListModel?.response[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 8.0,
              spreadRadius: 0.2,
            ),
          ],
        ),
        child: Column(
          children: [
            _buildBookingHeader(booking),
            _buildBookingDetails(booking),
            _buildBookingActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingHeader(BookingResponse? booking) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            booking?.title ?? "Non",
            style: GoogleFonts.alegreyaSans(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryPinkColor,
            ),
          ),
          _buildStartButton(),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: () => _showToast("Start Booking Tapped"),
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: AppColors.primaryPinkColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 3.2),
        child: Center(
          child: Text(
            "Start",
            style: GoogleFonts.alegreyaSans(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingDetails(BookingResponse? booking) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildDateTimeColumn("From", booking?.fromDate, booking?.fromTime),
          const SizedBox(width: 34),
          _buildDateTimeColumn("To", booking?.toDate, booking?.toTime),
        ],
      ),
    );
  }

  Widget _buildDateTimeColumn(String label, String? date, String? time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.alegreyaSans(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGreyColor,
          ),
        ),
        _buildIconTextRow("calendarDateIcon.svg", date),
        _buildIconTextRow("clockIcon.svg", time),
      ],
    );
  }

  Widget _buildIconTextRow(String iconName, String? text) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/svg/$iconName",
          height: 12,
        ),
        const SizedBox(width: 8),
        Text(
          text ?? "Non",
          style: GoogleFonts.alegreyaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.lightGreyColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton("Rate Us", "star.svg", AppColors.primaryBlueColor),
          _buildActionButton(
              "Geolocation", "pin.svg", AppColors.primaryBlueColor),
          _buildActionButton(
              "Surveillance", "radio.svg", AppColors.primaryBlueColor),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, String iconName, Color color) {
    return GestureDetector(
      onTap: () => _showToast("$text Tapped"),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3.3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: SvgPicture.asset(
                "assets/svg/$iconName",
                height: 12,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: GoogleFonts.alegreyaSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35, bottom: 7, top: 12),
          child: Text(
            "Packages",
            style: GoogleFonts.alegreyaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlueColor,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) => _buildPackageCard(index),
        ),
      ],
    );
  }

  Widget _buildPackageCard(int index) {
    final package = _packageController.packageListModel?.response[index];
    final isOdd = (index + 1) % 2 == 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: isOdd
              ? AppColors.pinkBackgroundColor
              : AppColors.blueBackgroundColor,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            _buildPackageHeader(index, package),
            _buildPackageDetails(package),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageHeader(int index, PackageResponse? package) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/svg/${_calendarImages[index]}",
            height: 28,
          ),
          _buildBookNowButton(index, package),
        ],
      ),
    );
  }

  Widget _buildBookNowButton(int index, PackageResponse? package) {
    final isOdd = (index + 1) % 2 == 1;
    return GestureDetector(
      onTap: () => _showToast("${package?.title ?? 'Non'} Booking Tapped"),
      child: Container(
        width: 77,
        decoration: BoxDecoration(
          color: isOdd ? AppColors.primaryPinkColor : AppColors.blueButtonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.2),
        child: Center(
          child: Text(
            "Book Now",
            style: GoogleFonts.alegreyaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageDetails(PackageResponse? package) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                package?.title ?? "Non",
                style: GoogleFonts.alegreyaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlueColor,
                ),
              ),
              Text(
                "₹ ${package?.price ?? 'Non'}",
                style: GoogleFonts.alegreyaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlueColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            package?.desc ?? "Non",
            maxLines: 3,
            style: GoogleFonts.alegreyaSans(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGreyColor,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
