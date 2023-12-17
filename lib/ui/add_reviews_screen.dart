// File: ui/add_reviews_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_v2/data/models/add%20reviews%20models/add_request_review_model.dart';
import 'package:restaurant_v2/provider/add_reviews_provider.dart';
import 'package:restaurant_v2/widgets/add_comment_widget.dart';

// ignore: must_be_immutable
class AddReviewsScreen extends StatelessWidget {
  AddReviewsScreen({required this.id, super.key});

  String id;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Consumer<AddReviewsProvider>(
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: AlertDialog(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Comment",
                      style: TextStyle(
                        color: Color(0xFF303840),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                )
              ],
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddCommentWidget(
                      titleCard: "Username",
                      controller: nameController,
                      maxLines: 1,
                    ),
                    AddCommentWidget(
                      titleCard: "Comment",
                      controller: reviewController,
                      maxLines: 5,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () async {
                      await value.postReview(AddRequestReviewsModel(
                          id: id,
                          name: nameController.text,
                          review: reviewController.text));
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: Text("Simpan",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
