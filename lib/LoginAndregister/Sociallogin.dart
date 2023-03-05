import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class SocailLogin extends StatelessWidget {
  const SocailLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '-Or sign up with-',
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/google-logo.png',
                height: 30,
              ),
            )
          ],
        )
      ],
    );
  }
}
