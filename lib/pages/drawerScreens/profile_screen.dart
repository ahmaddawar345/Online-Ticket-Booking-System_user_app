import 'package:flutter/material.dart';
import 'package:online_ticket_booking/components/circular_progressbar.dart';
import 'package:provider/provider.dart';

import '../../components/custom_textfield.dart';
import '../../components/my_big_button.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

// class ProfileScreen extends StatefulWidget {
//   final UserModel? user;
//   const ProfileScreen({super.key, required this.user});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   XFile? _selectedImage;
//   String? imgUrl = '';
//   final ImagePicker _picker = ImagePicker();
//   bool isLoading = false;
//   bool imageLoading = false;
//   UserModel? user;
//
//   @override
//   void initState() {
//     super.initState();
//     user = widget.user!;
//     emailController.text = user!.email;
//     nameController.text = user!.name;
//   }
//
//   Future<void> _pickImage() async {
//     try {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         setState(() {
//           imageLoading = true;
//           _selectedImage = image;
//         });
//         imgUrl = await uploadImage(image);
//       }
//     } catch (e) {
//       Utils.showErrorSnackBar("Error picking image: $e");
//     } finally {
//       setState(() {
//         imageLoading = false;
//       });
//     }
//   }
//
//   Future<String?> uploadImage(XFile image) async {
//     try {
//       // print('________________________________________> 1');
//       final storageRef =
//           FirebaseStorage.instance.ref().child('users/${auth.currentUser!.uid}/images/profile_image_${image.name}');
//       final uploadTask = storageRef.putFile(File(image.path));
//       final snapshot = await uploadTask.whenComplete(() => null);
//       final String downloadedUrl = await snapshot.ref.getDownloadURL();
//       return downloadedUrl;
//     } catch (e) {
//       Utils.showErrorSnackBar("Error Uploading image: $e");
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     final profileController = Provider.of<ProfileController>(context, listen: false);
//
//     ///
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       appBar: AppBar(title: Text('Edit Profile')),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 150),
//
//               /// Profile image
//               Center(
//                 child: GestureDetector(
//                     onTap: _pickImage,
//                     child: StreamBuilder(
//                       stream: FirebaseFirestore.instance.collection(userCollection).snapshots(),
//                       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                         // if (snapshot.connectionState == ConnectionState.waiting) {
//                         //   return const Center(child: CircularProgressIndicator());
//                         // } else
//                         if (snapshot.hasError) {
//                           return const Text('Some Error');
//                         } else if (!snapshot.hasData) {
//                           return const Text('No data');
//                         } else {
//                           return Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Container(
//                                 height: 100,
//                                 width: 100,
//                                 padding: const EdgeInsets.all(2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius: BorderRadius.circular(100),
//                                 ),
//                                 child: _selectedImage != null || imgUrl != ''
//                                     ? ClipRRect(
//                                         borderRadius: BorderRadius.circular(100),
//                                         child: _selectedImage != null
//                                             ? Image.file(File(_selectedImage!.path), fit: BoxFit.cover)
//                                             : imgUrl != ''
//                                                 ? Image.network(imgUrl!, fit: BoxFit.cover)
//                                                 : const Icon(Icons.person, color: Colors.white, size: 20),
//                                       )
//                                     // : user?.image != null && user?. != ''
//                                     // ? NetworkProfileImage(imagePath: user!.image)
//                                     : NetworkProfileImage(imagePath: onlineImageLink),
//                               ),
//                               Positioned(
//                                 bottom: 7,
//                                 right: 2,
//                                 child: Container(
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.grey,
//                                   ),
//                                   child: const Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                               if (imageLoading)
//                                 Opacity(
//                                   opacity: 0.5,
//                                   child: Container(
//                                     height: 95,
//                                     width: 95,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white70,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: circularIndicator,
//                                   ),
//                                 ),
//                             ],
//                           );
//                         }
//                       },
//                     )),
//               ),
//
//               /// User Name Text
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: Text(
//                     user!.name,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               ///edit name
//               buildLabelText('Name'),
//               const SizedBox(height: 8),
//               CustomTextField(
//                 controller: nameController,
//                 keyboardType: TextInputType.text,
//                 hint: 'Name',
//               ),
//               const SizedBox(height: 20),
//               buildLabelText('Email'),
//               const SizedBox(height: 8),
//               CustomTextField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 enabled: false,
//                 hint: 'User Email',
//               ),
//               const SizedBox(height: 20),
//
//               /// Save Button
//               isLoading
//                   ? circularIndicator
//                   : CustomButton(
//                       onPressed: () async {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         bool nameChanged = nameController.text.trim() != user!.name;
//                         bool imageChanged = imgUrl != '';
//                         // If either name or image has changed, update the user profile
//                         if (nameChanged || imageChanged) {
//                           // Update the user profile with the changed fields
//                           await profileController
//                               .updateUser(
//                             name: nameController.text,
//                             // image: imageChanged ? imgUrl! : user!.image,
//                           )
//                               .then((value) {
//                             setState(() {
//                               isLoading = false;
//                             });
//                             Navigator.pop(context);
//                             Utils.showSuccessSnackBar('Profile Updated');
//                           });
//                         } else {
//                           // If no changes, show a message or disable the button
//                           imageLoading
//                               ? Utils.showErrorSnackBar("Please wait for the image to upload then click save")
//                               : Utils.showErrorSnackBar("No changes to save.");
//                           setState(() {
//                             isLoading = false;
//                           });
//                         }
//                       },
//                       child: Text("Save"),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Text buildLabelText(String s) => Text(
//         s,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 18,
//         ),
//       );
// }
class ProfileScreen extends StatefulWidget {
  final UserModel? user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nicController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  UserModel? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    nameController.text = user!.name;
    phoneController.text = user!.phone;
    nicController.text = user!.nic;
    passwordController.text = user!.password!;
    emailController.text = user!.email;
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: AppColors.appBarBG,
        automaticallyImplyLeading: true,
        leading: const BackButton(),
      ),
      backgroundColor: AppColors.greenLight,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Center(
              //   child: CircleAvatar(
              //     radius: 50,
              //     backgroundImage: AssetImage('assets/placeholder.png'), // Placeholder image
              //   ),
              // ),
              const SizedBox(height: 20),
              buildLabelText('Name'),
              CustomTextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                hint: 'Name',
              ),
              const SizedBox(height: 20),
              buildLabelText('Phone'),
              CustomTextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                hint: 'Phone',
              ),
              SizedBox(height: 20),
              buildLabelText('NIC'),
              CustomTextField(
                controller: nicController,
                keyboardType: TextInputType.text,
                hint: 'NIC',
              ),
              const SizedBox(height: 20),
              buildLabelText('Email'),
              CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                enabled: false,
                hint: 'User Email',
              ),
              const SizedBox(height: 30),
              isLoading
                  ? circularIndicator
                  : Center(
                      child: MyBigButton(
                        label: 'UPDATE',
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          UserModel updatedUser = UserModel(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            nic: nicController.text.trim(),
                            password: user!.password,
                            email: user!.email, // Keep email the same
                          );

                          await profileController.updateUser(updatedUser: updatedUser).then((_) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                            Utils.showSuccessSnackBar('Profile Updated');
                          });
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildLabelText(String text) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      );
}

// import 'package:flutter/material.dart';
//
// import '../pages/home_screen.dart';
// import 'dchangepassword.dart';
//
// class Profile extends StatefulWidget {
//   static const String id = 'profile';
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SafeArea(
//           child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0XFF30D15D),
//           title: const Center(child: Text('Profile')),
//           leading: BackButton(
//             onPressed: () {
//               Navigator.pushNamed(context, HomeScreen.id);
//             },
//           ),
//           /* actions: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.notifications_outlined)),
//               ],*/
//         ),
//         body: Container(
//           constraints: const BoxConstraints.expand(),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0XFF0CF14C),
//                 Color(0XFF265533),
//               ],
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//             ),
//           ),
//           child: ListView(
//             children: [
//               Row(
//                 children: [
//                   const Image(image: AssetImage('assets/person.png')),
//                   const Text(
//                     'User Name',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   RawMaterialButton(
//                     onPressed: () {},
//                     splashColor: Colors.red,
//                     highlightColor: Colors.yellow,
//                     padding: const EdgeInsets.only(left: 140),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                     child: const Image(
//                       image: AssetImage('assets/editname.png'),
//                       height: 50,
//                       width: 50,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   const Image(image: AssetImage('assets/mobileno.png')),
//                   const Text(
//                     'Mobile No',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   RawMaterialButton(
//                     onPressed: () {},
//                     splashColor: Colors.red,
//                     highlightColor: Colors.yellow,
//                     padding: const EdgeInsets.only(left: 140),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                     child: const Image(
//                       image: AssetImage('assets/editname.png'),
//                       height: 50,
//                       width: 50,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Row(
//                 children: [
//                   Image(image: AssetImage('assets/email.png')),
//                   SizedBox(width: 4),
//                   Text(
//                     'Email',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Row(
//                 children: [
//                   Image(image: AssetImage('assets/residence.png')),
//                   SizedBox(width: 4),
//                   Text(
//                     'Residence',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   const Image(image: AssetImage('assets/changepassword.png')),
//                   const Text(
//                     'Chande Password',
//                     style: TextStyle(fontSize: 20, color: Colors.red),
//                   ),
//                   RawMaterialButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, dchangepassword.id);
//                     },
//                     splashColor: Colors.red,
//                     highlightColor: Colors.yellow,
//                     padding: const EdgeInsets.only(left: 55),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                     child: const Image(
//                       image: AssetImage('assets/changepassb.png'),
//                       height: 50,
//                       width: 50,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Column(
//                 children: [
//                   Container(
//                     width: 200,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.yellow,
//                     ),
//                     child: Center(
//                       child: TextButton(
//                         onPressed: () {},
//                         child: const Center(
//                           child: Text(
//                             'Save Change',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontFamily: 'Oswald-Medium',
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
