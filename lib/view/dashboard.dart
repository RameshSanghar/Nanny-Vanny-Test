import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny_vanny/config/theme/app_colors.dart';
import 'bookings.dart';
import 'home.dart';
import 'packages.dart';
import 'profile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PackagesScreen(),
    const BookingsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Used AdvancedDrawer Dependency here for custom behaviour of the drawer
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 0.8,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 30.0,
            spreadRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: _buildDrawer(),
      child: _buildMainScaffold(),
    );
  }

  Widget _buildDrawer() {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 25),
              _buildUserProfile(),
              const SizedBox(height: 25),
              _buildDrawerItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
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
        const SizedBox(height: 12),
        Text(
          "Emily Cyrus",
          style: GoogleFonts.alegreyaSans(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryPinkColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItems() {
    final drawerItems = [
      {'title': 'Home', 'onTap': () => _onDrawerItemTap('Home')},
      {
        'title': 'Book A Nanny',
        'onTap': () => _onDrawerItemTap('Book A Nanny')
      },
      {
        'title': 'How It Works',
        'onTap': () => _onDrawerItemTap('How It Works')
      },
      {
        'title': 'Why Nanny Vanny',
        'onTap': () => _onDrawerItemTap('Why Nanny Vanny')
      },
      {'title': 'My bookings', 'onTap': () => _onDrawerItemTap('My bookings')},
      {'title': 'My Profile', 'onTap': () => _onDrawerItemTap('My Profile')},
      {'title': 'Support', 'onTap': () => _onDrawerItemTap('Support')},
    ];

    return Column(
      children: drawerItems
          .map((item) => _buildDrawerItem(
              item['title'] as String, item['onTap'] as VoidCallback))
          .toList(),
    );
  }

  Widget _buildDrawerItem(String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          dense: true,
          onTap: onTap,
          title: Text(
            title,
            style: GoogleFonts.alegreyaSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlueColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Divider(
            color: AppColors.primaryPinkColor,
            thickness: 0.3,
          ),
        ),
      ],
    );
  }

  void _onDrawerItemTap(String itemName) {
    Fluttertoast.showToast(msg: "$itemName Tapped");
    _hideMenu();
  }

  Widget _buildMainScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: GestureDetector(
            onTap: _handleMenuButtonPressed,
            child: Center(
              child: SvgPicture.asset(
                "assets/svg/Menu_Icon.svg",
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    final items = [
      {'icon': "assets/svg/homeTabIcon.svg", 'label': 'Home'},
      {'icon': "assets/svg/saleTabIcon.svg", 'label': 'Packages'},
      {'icon': "assets/svg/bookingTabIcon.svg", 'label': 'Bookings'},
      {'icon': "assets/svg/profileTabIcon.svg", 'label': 'Profile'},
    ];

    return BottomNavigationBar(
      backgroundColor: AppColors.whiteColor,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedLabelStyle: GoogleFonts.alegreyaSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryPinkColor,
      ),
      unselectedLabelStyle: GoogleFonts.alegreyaSans(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.lightGreyColor,
      ),
      items: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return BottomNavigationBarItem(
          icon: Center(
            child: SvgPicture.asset(
              item['icon']!,
              height: _selectedIndex == index ? 26 : 22,
              color: _selectedIndex == index
                  ? AppColors.primaryPinkColor
                  : AppColors.lightGreyColor,
            ),
          ),
          label: item['label'],
        );
      }).toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.primaryPinkColor,
      unselectedItemColor: AppColors.lightGreyColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _hideMenu() {
    _advancedDrawerController.hideDrawer();
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
