import 'package:employee_management/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? headerText;
  final Widget? header;
  final String? hintText;
  final bool focusable;
  final bool large;
  final bool expands;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;
  final bool? enableInteractiveSelection;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final String? error;
  final TextCapitalization? textCapitalization;
  final int? lineLength;
  final bool shouldShowSuffixIcon;
  final bool readOnly;
  final bool turnOnLabelText;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final double borderRadius;
  final bool filled;
  final Color? fillColor;
  final BorderRadius? customRadius;
  final TextStyle? hintStyle;
  final Color? inputTextColor;

  final Widget? child;

  const CustomTextField({
    super.key,
    this.controller,
    this.headerText,
    this.header,
    this.hintText,
    this.focusable = false,
    this.large = false,
    this.expands = false,
    this.turnOnLabelText = false,
    this.onTap,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.keyboardType,
    this.child,
    this.inputFormatters,
    this.enableInteractiveSelection,
    this.obscureText,
    this.autocorrect,
    this.enableSuggestions,
    this.textInputAction,
    this.autofillHints,
    this.error,
    this.textCapitalization,
    this.onEditingComplete,
    this.lineLength,
    this.shouldShowSuffixIcon = false,
    this.readOnly = false,
    this.focusNode,
    this.suffixIcon,
    this.prefixIcon,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.hintStyle,
    this.borderRadius = 12.0,
    this.filled = false, // Default is not filled
    this.fillColor, // Optional fill color
    this.customRadius, // Optional custom radius
    this.inputTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final int minLines = large ? 4 : 1;
    final int? maxLines = lineLength ?? (expands ? null : (large ? 10 : 1));
    final Widget? defaultSuffixIcon =
        shouldShowSuffixIcon ? const Icon(Icons.chevron_right) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (headerText != null)
          Text(
            headerText!,
            style: const TextStyle(
              color: AppColors.greyColor,
            ),
          )
        else if (header != null)
          header!,
        if (child != null)
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.lightGreyColor,
                ),
                borderRadius:
                    customRadius ?? BorderRadius.circular(borderRadius),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: child!,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.chevron_right,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          TextFormField(
            autofocus: false,
            maxLength: maxLength,
            onChanged: onChanged,
            controller: controller,
            readOnly: readOnly,
            validator: validator,
            focusNode: readOnly ? _AlwaysDisabledFocusNode() : focusNode,
            minLines: minLines,
            maxLines: maxLines,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
              ),
              labelText: turnOnLabelText ? hintText : null,
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor),
              labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor),
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: suffixIcon,
                    )
                  : defaultSuffixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: defaultSuffixIcon,
                        )
                      : null,
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: prefixIcon,
                    )
                  : null,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              counterText: '',
              errorText: error?.isNotEmpty ?? false ? error : null,
              filled: filled, // Enabling filled field
              fillColor: filled
                  ? fillColor ?? AppColors.lightGreyColor
                  : null, // Applying fill color
              border: filled
                  ? OutlineInputBorder(
                      borderRadius:
                          customRadius ?? BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                        color: AppColors.fillBorderColor.withOpacity(.2),
                        width: 0.2,
                      ),
                    )
                  : border ??
                      OutlineInputBorder(
                        borderRadius:
                            customRadius ?? BorderRadius.circular(borderRadius),
                        borderSide: const BorderSide(
                          color: AppColors.greyColor,
                          width: 0.2,
                        ),
                      ),
              enabledBorder: filled
                  ? OutlineInputBorder(
                      borderRadius:
                          customRadius ?? BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                        color: AppColors.greyColor.withOpacity(.2),
                        width: 0.2,
                      ),
                    )
                  : enabledBorder ??
                      OutlineInputBorder(
                        borderRadius:
                            customRadius ?? BorderRadius.circular(borderRadius),
                        borderSide: const BorderSide(
                          color: AppColors.greyColor,
                        ),
                      ),
              errorBorder: filled
                  ? OutlineInputBorder(
                      borderRadius:
                          customRadius ?? BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(
                        color: AppColors.redColor,
                        width: 0.2,
                      ),
                    )
                  : errorBorder ??
                      OutlineInputBorder(
                        borderRadius:
                            customRadius ?? BorderRadius.circular(borderRadius),
                        borderSide: const BorderSide(
                          color: AppColors.redColor,
                        ),
                      ),
              disabledBorder: border ??
                  OutlineInputBorder(
                    borderRadius:
                        customRadius ?? BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(
                      color: AppColors.greyColor,
                    ),
                  ),
              focusedBorder: filled
                  ? OutlineInputBorder(
                      borderRadius:
                          customRadius ?? BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                        color: AppColors.fillBorderColor.withOpacity(.2),
                        width: 0.2,
                      ),
                    )
                  : focusedBorder ??
                      OutlineInputBorder(
                        borderRadius:
                            customRadius ?? BorderRadius.circular(borderRadius),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
            ),
            keyboardType: keyboardType,
            onTap: onTap,
            inputFormatters: inputFormatters,
            enableInteractiveSelection: enableInteractiveSelection,
            obscureText: obscureText ?? false,
            autocorrect: autocorrect ?? true,
            enableSuggestions: enableSuggestions ?? false,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            textCapitalization:
                textCapitalization ?? TextCapitalization.sentences,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: inputTextColor ?? AppColors.blackColor),
          ),
      ],
    );
  }
}

/// Used for ensuring that when we tap on the text field, there won't be a focus
/// ring around it.
class _AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
