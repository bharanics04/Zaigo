import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? keyVal;
  final String? imagePath;
  final String? labelText;
  final Color? labelColor;
  final String hintText;
  final Color? hintColor;
  final String? suffixText;
  final String? title;
  final IconData? prefixIcon;
  final double? prefixIconSize;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final double? suffixIconSize;
  final Color? suffixIconColor;
  final bool isFirstTextCaps;
  final int? maxLength;
  final bool isOnlyNumbers;
  final bool isOnlyAlphabets;
  final bool isAlphaNumerals;
  final bool isAllowNaturalDecimalNos;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final bool isExpand;
  final bool isEnable;
  final int maxLines;
  final int? minLines;
  final double mLeft;
  final double mRight;
  final double mTop;
  final double mBottom;
  final double circularBorder;
  final Function? onChange;
  final double verticalContentPadding;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? fillColor;
  final Color? enableBorderColor;
  final FocusNode? focusNode;
  final Function? suffixIconTap;
  final Function? prefixIconTap;
  final bool hideMaxLengthIndicator;
  final bool autoFocus;
  final Function? onTap;
  final double? height;
  final Widget? suffix;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final bool isObscureText;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onSubmit;

  const CustomTextField(
      {Key? key,
        this.controller,
        this.onTap,
        this.contentPadding,
        this.autoFocus = false,
        this.suffixIconTap,
        this.prefixIconTap,
        this.borderSide,
        this.hideMaxLengthIndicator = false,
        this.circularBorder = 4,
        this.suffixIconSize = 20,
        this.focusNode,
        this.enableBorderColor,
        this.imagePath,
        this.fillColor,
        this.fontSize,
        this.textAlign,
        this.verticalContentPadding = 15,
        this.prefixIconSize = 20,
        this.keyVal,
        this.isAllowNaturalDecimalNos = false,
        this.mLeft = 0,
        this.mRight = 0,
        this.mTop = 0,
        this.mBottom = 0,
        this.title,
        this.labelText,
        required this.hintText,
        this.suffixText,
        this.prefixIcon,
        this.prefix,
        this.prefixIconColor,
        this.suffixIcon,
        this.suffixIconColor,
        this.maxLength,
        this.isFirstTextCaps = false,
        this.isOnlyNumbers = false,
        this.suffix,
        this.isOnlyAlphabets = false,
        this.isAlphaNumerals = false,
        this.keyboardType,
        this.borderColor,
        this.labelColor,
        this.hintColor,
        this.isExpand = false,
        this.isEnable = true,
        this.onChange,
        this.maxLines = 1,
        this.minLines,
        this.height,
        this.validator,
        this.isObscureText = false,
        this.onSubmit
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: mLeft, right: mRight, top: mTop, bottom: mBottom),
        child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
          autofocus: autoFocus,
          validator: validator,
          focusNode: focusNode,
          textAlign: textAlign ?? TextAlign.start,
          expands: isExpand,
          maxLines: maxLines,
          obscureText: isObscureText,
          minLines: minLines,
          enabled: isEnable,
          style: TextStyle(color: Colors.black, fontSize: fontSize ?? 16),
          cursorColor: Colors.grey,
          controller: controller,
          maxLength: maxLength,
          keyboardType: keyboardType,
          inputFormatters: isOnlyNumbers
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : isOnlyAlphabets
              ? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z\\ ]"))
          ]
              : isAlphaNumerals
              ? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9\\ ]"))
          ]
              : isAllowNaturalDecimalNos
              ? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
          ]
              : null,
          textCapitalization:
          isFirstTextCaps ? TextCapitalization.sentences : TextCapitalization.none,
          decoration: InputDecoration(
            filled: true,
            counterText: hideMaxLengthIndicator ? "" : null,
            fillColor: fillColor ?? Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(circularBorder)),
                borderSide: borderSide??BorderSide(color: borderColor ?? Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(circularBorder)),
                borderSide: borderSide??BorderSide(
                    color: enableBorderColor ?? borderColor ?? Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(circularBorder)),
                borderSide: borderSide??BorderSide(color: borderColor ?? Colors.transparent)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(circularBorder)),
                borderSide: borderSide??BorderSide(color: borderColor ?? Colors.transparent)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(circularBorder)),
                borderSide: borderSide??BorderSide(color: borderColor ?? Colors.transparent)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(circularBorder)),
                borderSide: borderSide??BorderSide(color: borderColor ?? Colors.transparent)),
            contentPadding: contentPadding??const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            labelText: labelText,
            labelStyle: TextStyle(color: labelColor ?? Colors.grey),
            hintStyle: TextStyle(color: hintColor ?? Colors.black45, fontSize: 16),
            hintText: hintText,
            suffixText: suffixText,
            suffixIcon: suffix,
            suffixStyle: const TextStyle(
              color: Colors.red,
            ),
            prefixIcon: prefixIcon!=null?GestureDetector(child: Icon(prefixIcon,color: prefixIconColor),onTap: (){
              if(prefixIconTap!=null){
                prefixIconTap!();
              }
            }):prefix
          ),
          onChanged: (val) {
            if (onChange != null) {
              onChange!(val);
            }
          },
          onFieldSubmitted: onSubmit
        ));
  }
}


