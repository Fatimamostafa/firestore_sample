import 'package:flutter/material.dart';
import 'package:glint_test/utils/spacing.dart';
import 'package:glint_test/values/colors.dart';
import 'package:rxdart/rxdart.dart';

class TextInputForm extends StatefulWidget {
  final String value;
  final String title;
  final FocusNode? current;
  final FocusNode? next;
  final bool enabled;
  final bool errorText;
  final String hintText;
  final TextInputAction? action;
  final Function(String? text)? onSaved;
  final Function(String text)? onChanged;
  final Function(String?)? validator;
  final TextInputType keyboardType;
  final bool borderNone;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final bool? autoFocus;
  final Color? fillColor;
  final Widget? prefixIcon;
  final int? maxLine;
  final int? maxLength;

  const TextInputForm(
      {Key? key,
      this.autoFocus,
      this.keyboardType = TextInputType.text,
      this.errorText = false,
      this.hintText = 'Type here',
      this.title = '',
      this.value = '',
      this.onSaved,
      this.current,
      this.next,
      this.action,
      this.enabled = true,
      this.controller,
      this.onChanged,
      this.validator,
      this.fillColor,
      this.prefixIcon,
      this.borderNone = false,
      this.onTap,
      this.maxLine = 1,
      this.maxLength})
      : super(key: key);

  @override
  _TextInputFormState createState() {
    return _TextInputFormState();
  }
}

class _TextInputFormState extends State<TextInputForm> {
  final TextInputBloc bloc = TextInputBloc();

  @override
  void initState() {
    super.initState();
    if (widget.keyboardType == TextInputType.visiblePassword) {
      bloc.updateVisibility(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  double radius = 40;

  @override
  Widget build(BuildContext context) {
    // print(widget.value);
    return StreamBuilder<bool>(
        stream: bloc.subjectPasswordVisibility,
        builder: (context, snapshot) {
          bool obscureText =
              snapshot.hasData ? (snapshot.data ?? false) : false;
          return StreamBuilder<bool>(
              stream: bloc.subjectFocus,
              builder: (context, snapshotFocus) {
                return Container(
                  height: widget.maxLine == 1 ? applySpacing(8) : null,
                  padding: EdgeInsets.symmetric(
                      vertical: applySpacing(1), horizontal: applySpacing(1.5)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.0),
                    color: Colors.transparent,
                    border: Border.all(
                        color: widget.borderNone
                            ? Colors.transparent
                            : snapshotFocus.hasData &&
                                    (snapshotFocus.data ?? false)
                                ? ColorsX.primaryBlue
                                : ColorsX.secondary,
                        width: 2),
                  ),
                  child: Row(
                    children: [
                      widget.prefixIcon != null
                          ? Padding(
                              padding:
                                  EdgeInsets.only(right: applySpacing(0.5)),
                              child: widget.prefixIcon,
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: Focus(
                          onFocusChange: (focus) {
                            bloc.setFocus(focus);
                          },
                          child: TextFormField(
                            maxLines: widget.maxLine,
                            maxLength: widget.maxLength,
                            textAlignVertical: TextAlignVertical.center,
                            onTap: widget.onTap,
                            readOnly: widget.onTap != null,
                            showCursor: widget.onTap == null,
                            cursorColor: ColorsX.black,
                            keyboardType: widget.keyboardType,
                            autofocus: widget.autoFocus ?? false,
                            enabled: widget.enabled ? true : false,
                            controller: widget.controller,
                            initialValue:
                                widget.controller == null ? widget.value : null,
                            obscureText: widget.keyboardType ==
                                    TextInputType.visiblePassword
                                ? obscureText
                                : false,
                            focusNode: widget.current,
                            textInputAction: widget.action,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: applySpacing(1.2),
                                ),
                                filled: false,
                                fillColor: Colors.transparent,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                suffixIcon: widget.keyboardType ==
                                        TextInputType.visiblePassword
                                    ? _getSuffixButton(snapshot)
                                    : const SizedBox.shrink(),
                                hintText: widget.hintText,
                                errorStyle: TextStyle(
                                    fontSize: widget.errorText ? 12 : 0),
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                )),
                            onFieldSubmitted: (term) {
                              if (widget.current != null) {
                                widget.current?.unfocus();
                              }
                              if (widget.current != widget.next) {
                                FocusScope.of(context)
                                    .requestFocus(widget.next);
                              }
                            },
                            onChanged: widget.onChanged,
                            onSaved: widget.onSaved,
                            //validator: widget.validator,
                            validator: (val) {
                              return widget.validator!(val);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  _getSuffixButton(AsyncSnapshot<bool> snapshot) {
    return IconButton(
        icon: Icon(
          snapshot.hasData && snapshot.data!
              ? Icons.visibility_off
              : Icons.visibility,
          semanticLabel: snapshot.hasData && snapshot.data!
              ? 'hide password'
              : 'show password',
          color: Colors.grey,
        ),
        onPressed: () {
          bloc.updateVisibility(!snapshot.data!);
        });
  }
}

class TextInputBloc {
  final BehaviorSubject<bool> _subjectPasswordVisibility =
      BehaviorSubject<bool>();

  BehaviorSubject<bool> get subjectPasswordVisibility =>
      _subjectPasswordVisibility;

  final BehaviorSubject<bool> _subjectFocus = BehaviorSubject<bool>();

  BehaviorSubject<bool> get subjectFocus => _subjectFocus;

  TextInputBloc() {
    _subjectPasswordVisibility.sink.add(false);
  }

  dispose() {
    _subjectPasswordVisibility.close();
    _subjectFocus.close();
  }

  setFocus(bool focus) {
    _subjectFocus.sink.add(focus);
  }

  updateVisibility(bool v) {
    _subjectPasswordVisibility.sink.add(v);
  }
}
