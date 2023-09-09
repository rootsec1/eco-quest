import 'package:ecoquest/constants.dart';
import 'package:ecoquest/theme.dart';
import 'package:flutter/material.dart';

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 24,
  });

  final String text;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TitleAndSubTitleWidget extends StatelessWidget {
  const TitleAndSubTitleWidget({
    super.key,
    required this.titleText,
    required this.subTitleText,
  });
  final String titleText;
  final String subTitleText;

  @override
  Widget build(BuildContext context) {
    String subtitle = subTitleText;
    if (subtitle.length > 48) {
      subtitle = '${subtitle.substring(0, 48)}...';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTitleWidget(
          text: titleText,
        ),
        CustomTitleWidget(
          text: subtitle,
          fontSize: standardSeparation - 2,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }
}

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: true,
      maxLength: 128,
      controller: emailController,
      decoration: const InputDecoration(
        iconColor: backgroundColor,
        prefixIcon: Icon(Icons.email_outlined),
        labelText: 'email*',
      ),
      textCapitalization: TextCapitalization.none,
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
    required this.passwordController,
    this.labelText = 'password*',
  });

  final TextEditingController passwordController;
  final String labelText;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 64,
      obscureText: !_isPasswordVisible,
      controller: widget.passwordController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key_outlined),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() => _isPasswordVisible = !_isPasswordVisible);
          },
          child: const Icon(Icons.visibility),
        ),
        labelText: widget.labelText,
      ),
    );
  }
}
