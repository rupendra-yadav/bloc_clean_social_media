import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final bool isFollowing;
  final bool isFollowButton;

  const FollowButton({
    super.key,
    required this.function,
    required this.isFollowing,
    required this.isFollowButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: isFollowButton
                ? isFollowing
                      ? secondaryColor
                      : blueColor
                : Colors.red,
            border: Border.all(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: double.infinity,
          height: 40,
          child: isFollowButton
              ? Text(
                  isFollowing ? "Unfollow" : "Follow",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  "Sign Out",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
