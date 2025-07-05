import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/home/logic/home_page_controller.dart';
import 'package:drop4life/features/home/presentation/widgets/near_by_request_widget.dart';
import 'package:drop4life/features/home/presentation/widgets/request_dontate_buttom.dart';
import 'package:drop4life/features/notification/presentation/notifications_page.dart';
import 'package:drop4life/features/request_blood_form/presentation/request_blood_form_page.dart';
import 'package:drop4life/shared/widgets/carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  final (User?, Map<String, dynamic>) record;
  const HomePage({required this.record, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = record.$1;
    var data = record.$2;
    var size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hi,${data['name'] ?? 'John'}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:
                Theme.of(context).brightness == Brightness.light
                    ? AppColors.textDark
                    : AppColors.textLight,
          ),
        ),
        actions: [
          IconButton(
            onPressed:
                () => GoRouter.of(context).push(NotificationsPage.pageName),
            icon: Icon(
              Icons.notifications,
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? AppColors.textDark
                      : AppColors.textLight,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Show user's name and email
                        Row(
                          children: [
                            CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person)),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.displayName ?? 'No Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user?.email ?? 'No Email',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(),
                        // Add another account option
                        ListTile(
                          leading: Icon(Icons.person_add),
                          title: Text('Add another account'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to add account logic here
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.add,
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? AppColors.textDark
                      : AppColors.textLight,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CarouselWidget(
              height: height,
              width: width,
              items:
                  HomePageController.bannerImages.map((e) {
                    return Container(
                      width: width * 0.95,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(e),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            // SizedBox(width: width, height: 50),
            RequestBloodButton(
              buttonText: 'Ask for blood help',
              width: width,
              onPressed:
                  () => GoRouter.of(
                    context,
                  ).push(RequestBloodFormPage.pageName, extra: record),
            ),
            SizedBox(
              width: width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearby Blood Requests 🩸',
                    softWrap: true,
                    style: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.textLight
                              : AppColors.textDark,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textLight
                            : AppColors.textDark,
                  ),
                ],
              ),
            ),
            NearByRequestWidget(
              height: height,
              width: width,
              data: data,
              user: user,
            ),
          ],
        ),
      ),
    );
  }
}

// SizedBox(
//                 width: width,
//                 height: height * 0.3,
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(
//                       29.3958,
//                       71.6836,
//                     ), // Replace with real coordinates
//                     zoom: 14,
//                   ),
//                   mapType: MapType.normal,
//                   onMapCreated: (GoogleMapController controller) {
//                     // Do something when map is ready
//                   },
//                 ),
//               ),
