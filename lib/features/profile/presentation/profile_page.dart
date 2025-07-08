import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/profile/logic/profile_page_controller.dart';
import 'package:drop4life/features/request_blood_form/presentation/request_blood_form_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final (User?, Map<String, dynamic>) record;
  const ProfilePage({super.key, required this.record});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late Map<String, dynamic> data;
  @override
  void initState() {
    super.initState();
    data = widget.record.$2;

    Future.microtask(() {
      final profilePageStateNotifier = ref.read(profilePageProvider.notifier);
      profilePageStateNotifier.setDonationCount(
        int.tryParse(data['donationCount']?.toString() ?? '') ?? 0,
      );
      profilePageStateNotifier.setRequestCount(
        int.tryParse(data['requestCount']?.toString() ?? '') ?? 0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final profilePageState = ref.watch(profilePageProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            height: height * 0.3,
            width: double.infinity,
            color: AppColors.primaryColor,
            padding: EdgeInsets.only(top: height * 0.06),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: width * 0.13,
                  backgroundImage: AssetImage(
                    "assets/images/user_img.png", // Replace with real image
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  data['name'] ?? 'Jhon Martin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data['email'] ?? 'Jhon88@gmail.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: width * 0.035,
                  ),
                ),
                SizedBox(height: height * 0.015),
              ],
            ),
          ),

          // Buttons
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.call),
                    label: Text("Call Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.05),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed:
                        () => GoRouter.of(context).push(
                          RequestBloodFormPage.pageName,
                          extra: widget.record,
                        ),
                    icon: Icon(
                      Icons.send,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.textLight
                              : AppColors.textDark,
                    ),
                    label: Text(
                      "Request",
                      style: TextStyle(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.textLight
                                : AppColors.textDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile(data['bloodgroup'] ?? "A+", "Blood Type", width),
                _infoTile(
                  profilePageState.donateCount.toString(),
                  "Donated",
                  width,
                ),
                _infoTile(
                  profilePageState.requestCount.toString(),
                  "Requested",
                  width,
                ),
              ],
            ),
          ),

          SizedBox(height: height * 0.03),

          // Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              children: [
                SwitchListTile(
                  title: Text("Available for donate"),
                  value: profilePageState.isAvailbaleForDonate,
                  onChanged: (_) {
                    ref
                        .read(profilePageProvider.notifier)
                        .setAvailableForDonate(
                          value: !profilePageState.isAvailbaleForDonate,
                        );
                  },
                  activeColor: AppColors.primaryColor,
                ),
                ListTile(
                  leading: Icon(Icons.person_add_alt_1),
                  title: Text("Invite a friend"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text("Get help"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: AppColors.primaryColor),
                  title: Text(
                    "Log out",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            title: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.redAccent),
                                SizedBox(width: 8),
                                Text(
                                  'Log Out?',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            content: Text(
                              'Are you sure you want to log out?\nYou’ll need to sign in again to access your profile.',
                              style: TextStyle(fontSize: 15),
                            ),
                            actionsAlignment: MainAxisAlignment.end,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.textDark
                                        : AppColors.textLight,
                                  ),
                                ),
                                child: Text(
                                  'Stay Logged In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppColors.textLight
                                            : AppColors.textDark,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ProfilePageController.signOutFromGoogle(
                                    context,
                                  );
                                  ref
                                      .read(
                                        bottomNavigationRiverpdProvider
                                            .notifier,
                                      )
                                      .onPressedNavItem(0);
                                  ref
                                      .read(aiChatPageProvider.notifier)
                                      .resetChat();
                                  ref
                                      .read(profilePageProvider.notifier)
                                      .resetState();
                                },
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String value, String label, double width) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: width * 0.035, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
