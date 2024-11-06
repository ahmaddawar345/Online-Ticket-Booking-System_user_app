import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/components/custom_textfield.dart';

import '../../components/customText.dart';
import '../../components/my_big_button.dart';
import '../../models/feedback_model.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';

class AddFeedbackScreen extends StatefulWidget {
  static const String id = 'addFeedbackScreen';
  const AddFeedbackScreen({super.key});

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  FeedBackModel? feedBackModel;
  bool isLoading = false;
  final feedBackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  addFeedBack() async {
    setState(() {
      isLoading = true;
    });
    FeedBackModel newFeedBack = FeedBackModel(id: '', description: feedBackController.text);
    final DocumentReference feedBackRef = fireStore.collection(feedBackCollection).doc(auth.currentUser!.uid);
    await feedBackRef.set(newFeedBack.toJson()).then((value) {
      setState(() {
        isLoading = false;
        Navigator.pop(context);
      });
    });
  }

  @override
  void initState() {
    fetchFeedback();
    super.initState();
  }

  Future<void> fetchFeedback() async {
    final DocumentReference feedBackRef = fireStore.collection(feedBackCollection).doc(auth.currentUser!.uid);
    // Fetch the feedback document from Firestore
    final DocumentSnapshot feedBackDoc = await feedBackRef.get();
    if (feedBackDoc.exists) {
      feedBackModel = FeedBackModel.fromJson(feedBackDoc.data() as Map<String, dynamic>, feedBackRef.id);
      setState(() {
        feedBackController.text = feedBackModel!.description;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const CustomText(text: 'Add FeedBack'),
        automaticallyImplyLeading: true,
        leading: BackButton(),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: feedBackController,
              lines: 10,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your feedback';
                }
                return null;
              },
              hint: "Add Your FeedBack....",
            ),

            ///Submit Button
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : MyBigButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addFeedBack();
                        Navigator.pop(context);
                      }
                    },
                    label: 'Submit',
                  )
          ],
        ),
      ),
    );
  }
}
