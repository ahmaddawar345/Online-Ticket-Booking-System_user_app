import 'package:flutter/material.dart';
import 'package:online_ticket_booking/pages/auth/auth_screen.dart';
import 'package:online_ticket_booking/pages/drawerScreens/terms_and_conditions.dart';
import 'package:online_ticket_booking/utils/styles.dart';
import 'package:provider/provider.dart';

import '../components/circular_progressbar.dart';
import '../components/custom_button.dart';
import '../components/drawer_list_tile.dart';
import '../controllers/profile_controller.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import 'drawerScreens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _homescreenState();
}

class _homescreenState extends State<HomeScreen> {
  bool loggingOut = false;
  // UserModel? currentUser;

  ///user
  buildUser() {
    final profileController = Provider.of<ProfileController>(context, listen: true);
    return StreamBuilder(
      stream: profileController.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return circularIndicator;
        } else {
          Map<String, dynamic>? data = snapshot.data!.data();
          final user = UserModel.fromJson(data!);
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(user.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.yellow,
                )),
          );
        }
      },
    );
  }

  @override
  void initState() {
    Provider.of<ProfileController>(context, listen: false).getCurrentUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF30D15D),
          title: const Center(child: Text('Home')),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          ],
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: gradientGreen,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  height: 300,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      mainAxisSpacing: 10, // Spacing between rows
                      crossAxisSpacing: 15, // Spacing between columns
                      childAspectRatio: 1, // Adjust to control item height/width ratio
                    ),
                    itemCount: homeScreenButtons.length,
                    itemBuilder: (context, index) {
                      final button = homeScreenButtons[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButton(
                            onPressed: () {
                              Navigator.pushNamed(context, button['route']);
                            },
                            child: Image.asset(button['iconPath'], height: 50, width: 50),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            button['label'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: buildDrawer(profileController, context),
      ),
    );
  }

  Drawer buildDrawer(ProfileController profileController, BuildContext context) {
    return Drawer(
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(gradient: gradientGreen),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              currentAccountPicture: Container(
                height: 95,
                width: 95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(onlineImageLink),
                    // NetworkImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              accountName: buildUser(),
              accountEmail: Text(profileController.currentUser.email),
            ),
            DrawerListTile(
              iconPath: IconImages.home,
              title: 'Home',
              onTap: () => Navigator.pushNamed(context, HomeScreen.id),
            ),
            DrawerListTile(
                iconPath: IconImages.profile,
                title: 'Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(user: profileController.currentUser),
                    ),
                  );
                }),
            DrawerListTile(
              iconPath: IconImages.T_and_Cs,
              title: 'Terms & Condition',
              onTap: () => Navigator.pushNamed(context, TermsAndConditionsScreen.id),
            ),
            // DrawerListTile(
            //   iconPath: IconImages.companyProfile,
            //   title: 'Company Profile',
            //   onTap: () => Navigator.pushNamed(context, CompanyProfile.id),
            // ),
            // DrawerListTile(
            //   iconPath: IconImages.contact,
            //   title: 'Contact Us',
            //   onTap: () => Navigator.pushNamed(context, ContactUs.id),
            // ),
            loggingOut
                ? circularIndicator
                : DrawerListTile(
                    iconPath: IconImages.logout,
                    title: 'Logout',
                    onTap: () async {
                      await auth.signOut();
                      await auth.currentUser?.reload();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          ));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
