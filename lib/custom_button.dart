import 'package:flutter/material.dart';
import 'custom_progress.dart';
import 'custom_text.dart';

abstract class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? activeColor;
  final Color? disabledColor;
  final String text;
  final Widget Function(String)? builderText;
  final double border;
  final double elevation;
  final double height;
  final double width;
  final double marginVertical;
  final double marginHorizontal;
  final double? textSize;
  final Color? textColor;
  final bool enableEffectClicked;
  final TextStyle Function(TextStyle style)? textStyle;

  const CustomButton({
    super.key,
    this.onPressed,
    this.enableEffectClicked = true,
    this.activeColor,
    this.disabledColor,
    required this.text,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.builderText,
    this.border = 8.0,
    this.height = 50.0,
    required this.width,
    this.elevation = 8.0,
    this.marginVertical = 0.0,
    this.marginHorizontal = 0.0,
  }) : assert(disabledColor != null);

  body({required Widget child, required BuildContext context}) {
    var _activeColor = activeColor ?? Theme.of(context).colorScheme.secondary;

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginVertical),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border),
        child: MaterialButton(
          splashColor: (enableEffectClicked) ? null : Colors.transparent,
          highlightColor: (enableEffectClicked) ? null : Colors.transparent,
          disabledColor:disabledColor,
          elevation: elevation,
          color: _activeColor,
          height: height,
          minWidth: double.infinity / 2,
          onPressed: onPressed,
          padding: (builderText != null) ? EdgeInsets.zero : null,
          child: (builderText != null) ? builderText!(text) : child,
        ),
      ),
    );
  }
}

class BRButton extends CustomButton {
  BRButton({
    super.key,
    this.isLoading = false,
    this.ignorePlatform = false,
    required String title,
    double border = 8.0,
    double elevation = 8.0,
    TextStyle Function(TextStyle style)? textStyle,
    Color? activeColor,
    Color? disabledColor,
    double height = 50.0,
    double width = double.infinity,
    bool enableEffectClicked = true,
    Widget Function(String value)? builderText,
    VoidCallback? onPressed,
    double? textSize,
    Color? textColor,
    double marginVertical = 0.0,
    double marginHorizontal = 0.0,
  }) : super(
            text: title,
            activeColor: activeColor,
            disabledColor: disabledColor ?? Colors.grey[200],
            textStyle: textStyle,
            textSize: textSize,
            enableEffectClicked: enableEffectClicked,
            builderText: isLoading
                ? (x) => CustomProgress(
                      color: activeColor!,
                      ignorePlatform: ignorePlatform,
                    )
                : builderText,
            textColor: textColor,
            elevation: elevation,
            height: height,
            width: width,
            border: border,
            marginVertical: marginVertical,
            marginHorizontal: marginHorizontal,
            onPressed: (isLoading) ? null : onPressed);

  final bool isLoading;

  final bool ignorePlatform;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return body(
          context: context,
          child: CustomTxt(
            text,
            textStyle: textStyle,
            textSize: textSize,
            textColor: textColor,
          ));
    } else {
      FocusScope.of(context).unfocus();
      return body(
          context: context,
          child: Center(
            child: CustomProgress(
              color: activeColor!,
              ignorePlatform: ignorePlatform,
            ),
          ));
    }
  }
}



