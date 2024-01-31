import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_manager/env/color/colors.dart';

import 'env/lang/texts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(AppTexts.guide),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            height20(),
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.linkManagerBackgroundColor,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 0),
                        color: AppColors.linkManagerBackgroundColor,
                      )
                    ]),
                child: Image.asset(
                  'assets/image/guide.gif',
                ),
              ),
            ),
            height20(),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.circleChevronLeft,
                    size: 40,
                    color: AppColors.linkManagerBackgroundColor,
                  ),
                ),
              ),
            ),
            height30()
          ],
        ),
      ),
    );
  }

  SizedBox height30() => const SizedBox(height: 30);
  SizedBox height20() => const SizedBox(height: 20);
  SizedBox height10() => const SizedBox(height: 10);
}

class SubjectText extends StatelessWidget {
  const SubjectText({
    super.key,
    required this.subjectText,
  });

  final String subjectText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5 * 4),
      child: Text(
        subjectText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.linkManagerBackgroundColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
