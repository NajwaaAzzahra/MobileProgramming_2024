// // import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
// // import 'package:dis_app/utils/constants/colors.dart';

enum IconPosition { left, right, none }

// class DisCustomInputField extends StatelessWidget {
//   final String? label;
//   final IconData? icon;
//   final String? placeholder;
//   final double width;
//   final double height;
//   final IconPosition iconPosition;
//   final TextEditingController? controller;
//   final Color focusColor;
//   final Color hoverColor;
//   final int maxLength;

//   const DisCustomInputField({
//     Key? key,
//     this.label,
//     this.icon,
//     this.placeholder,
//     this.height = 60.0,
//     this.width = double.infinity,
//     this.iconPosition = IconPosition.none,
//     this.controller,
//     this.focusColor = Colors.orange,
//     this.hoverColor = Colors.deepPurple,
//     this.maxLength = 300, // Set max character limit
//   }) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       maxLength: maxLength,
//       decoration: InputDecoration(
//         hintText: placeholder,
//         hintStyle: TextStyle(color: Colors.deepPurple),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(color: hoverColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(color: focusColor, width: 2.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(color: hoverColor),
//         ),
//         prefixIcon: iconPosition == IconPosition.left && icon != null
//             ? Icon(icon, color: Colors.deepPurple)
//             : null,
//         suffixIcon: iconPosition == IconPosition.right && icon != null
//             ? Icon(icon, color: Colors.deepPurple)
//             : null,
//         counterText: '', // Suppress default counter to use custom format
//       ),
//       cursorColor: focusColor,
//       buildCounter: (context,
//               {required currentLength, maxLength, required isFocused}) =>
//           Text(
//         '$currentLength/$maxLength',
//         style: const TextStyle(fontSize: 12, color: Colors.deepPurple),
//       ),
//     );
//   }
// }

class DisCustomInputField extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String? placeholder;
  final double width;
  final double height;
  final IconPosition iconPosition;
  final TextEditingController? controller;
  final Color focusColor;
  final Color hoverColor;
  final int maxLength;

  const DisCustomInputField({
    Key? key,
    this.label,
    this.icon,
    this.placeholder,
    this.height = 60.0,
    this.width = double.infinity,
    this.iconPosition = IconPosition.none,
    this.controller,
    this.focusColor = Colors.orange,
    this.hoverColor = Colors.deepPurple,
    this.maxLength = 300, // Set max character limit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height, // Set the height dynamically
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.deepPurple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: hoverColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: focusColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: hoverColor),
          ),
          prefixIcon: iconPosition == IconPosition.left && icon != null
              ? Icon(icon, color: Colors.deepPurple)
              : null,
          suffixIcon: iconPosition == IconPosition.right && icon != null
              ? Icon(icon, color: Colors.deepPurple)
              : null,
          counterText: '', // Suppress default counter to use custom format
        ),
        cursorColor: focusColor,
        buildCounter: (context,
                {required currentLength, maxLength, required isFocused}) =>
            Text(
          '$currentLength/$maxLength',
          style: const TextStyle(fontSize: 12, color: Colors.deepPurple),
        ),
      ),
    );
  }
}

