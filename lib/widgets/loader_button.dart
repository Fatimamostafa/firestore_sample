import 'package:flutter/material.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/values/colors.dart';
import 'package:glint_test/values/constants.dart';
import 'package:glint_test/widgets/text.dart';

import 'loading_indicator.dart';

enum DecorationType {
  enable,
  disable,
  white,
  black,
}

class LoaderButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final bool isEnabled;
  final Color textColor;
  final String? icon;
  final double? radius;
  final double? verticalPadding;
  final bool hideTextOnLoading;
  final DecorationType decorationType;
  final double? fontSize;

  const LoaderButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.icon,
      this.radius,
      this.isLoading = false,
      this.width,
      this.verticalPadding,
      this.hideTextOnLoading = false,
      this.height,
      this.textColor = Colors.black,
      this.isEnabled = true,
      this.decorationType = DecorationType.enable,
      this.fontSize})
      : super(key: key);

  getDecoration(bool isEnabled) {
    DecorationType type = isEnabled ? decorationType : DecorationType.disable;

    switch (type) {
      case DecorationType.enable:
        return BoxDecoration(
            borderRadius:
                BorderRadius.circular(radius ?? Values.buttonRadius()),
            gradient: const LinearGradient(
                colors: [ColorsX.primaryPurple, ColorsX.primaryBlue]));
      case DecorationType.disable:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
          border: Border.all(color: ColorsX.secondary, width: 2),
          color: ColorsX.white,
        );
      case DecorationType.white:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
          border: Border.all(color: ColorsX.white, width: 1),
          color: ColorsX.white,
        );
      case DecorationType.black:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
          border: Border.all(color: ColorsX.black, width: 1),
          color: ColorsX.black,
        );
    }
  }

  getTextColor(bool isEnabled) {
    DecorationType type = isEnabled ? decorationType : DecorationType.disable;
    switch (type) {
      case DecorationType.black:
      case DecorationType.enable:
      case DecorationType.disable:
        return ColorsX.secondary;
      default:
        return ColorsX.primaryPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
      child: Material(
          child: InkWell(
        onTap: isLoading || !isEnabled ? () {} : onPressed,
        child: Opacity(
          opacity: isLoading ? 0.7 : 1.0,
          child: Container(
              decoration: getDecoration(isEnabled),
              width: width ?? double.infinity,
              height: height ?? applySpacing(6),
              child: Stack(
                children: [
                  hideTextOnLoading && isLoading
                      ? const SizedBox.shrink()
                      : Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Spacing(
                                size: 1.2,
                                direction: Axis.horizontal,
                              ),
                              icon != null && icon!.isNotEmpty
                                  ? Image.asset(
                                      icon!,
                                      width: applySpacing(3),
                                    )
                                  : Container(
                                      width: applySpacing(3),
                                    ),
                            ],
                          ),
                        ),
                  hideTextOnLoading && isLoading
                      ? const SizedBox.shrink()
                      : Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: TextX(
                                    text: label,
                                    color: getTextColor(isEnabled),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: hideTextOnLoading
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: [
                        isLoading
                            ? const LoadingIndicator()
                            : Container(
                                width: applySpacing(3),
                              ),
                        hideTextOnLoading
                            ? const SizedBox.shrink()
                            : SizedBox(
                                width: applySpacing(2),
                              )
                      ],
                    ),
                  )
                ],
              )),
        ),
      )),
    );
  }
}
