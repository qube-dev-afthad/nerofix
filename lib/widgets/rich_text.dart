// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

FontWeight getFontWeight(String name) {
  switch (name) {
    case '100':
      return FontWeight.w100;
    case '200':
      return FontWeight.w200;
    case '300':
      return FontWeight.w300;
    case '400':
      return FontWeight.w400;
    case '500':
      return FontWeight.w500;
    case '600':
      return FontWeight.w600;
    case '700':
      return FontWeight.w700;
    case '800':
      return FontWeight.w800;
    case '900':
      return FontWeight.w900;

    default:
      return FontWeight.w400;
  }
}

TextAlign getTextAlign(String name) {
  switch (name) {
    case 'center':
      return TextAlign.center;

    default:
      return TextAlign.start;
  }
}

class TextModel {
  final String text;

  final bool isHyperlink;
  final int? maxLines;
  final String? format;
  final TextStyle? style;
  final String? linkUrl;

  final VoidCallback? onTap;

  // String get formattedText =>
  //     format != null ? Assistant.formatString(text, format) : text;

  const TextModel({
    required this.text,
    this.isHyperlink = true,
    this.maxLines = 1,
    this.format,
    this.style,
    this.linkUrl,
    this.onTap,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isHyperlink': isHyperlink,
      'maxLines': maxLines,
      'format': format,
      'linkUrl': linkUrl,
    };
  }

  TextModel copyWith({
    String? text,
    bool? isHyperlink,
    int? maxLines,
    String? format,
    TextStyle? style,
    String? linkUrl,
    VoidCallback? onTap,
  }) {
    return TextModel(
      text: text ?? this.text,
      isHyperlink: isHyperlink ?? this.isHyperlink,
      maxLines: maxLines ?? this.maxLines,
      format: format ?? this.format,
      style: style ?? this.style,
      linkUrl: linkUrl ?? this.linkUrl,
      onTap: onTap ?? this.onTap,
    );
  }

  factory TextModel.fromMap(Map<String, dynamic> map) {
    return TextModel(
      text: map['text'] as String,
      isHyperlink: map['isHyperlink'] as bool,
      maxLines: map['maxLines'] != null ? map['maxLines'] as int : null,
      format: map['format'] != null ? map['format'] as String : null,
      style: map['style'] != null
          ? TextStyle(
              fontSize: map['style']['fontSize'].toDouble(),
              fontFamily: "spaceGrotesk",
              fontWeight: getFontWeight(map['style']['weight']),
              color: HexColor(map['style']['color']))
          : null,
      linkUrl: map['linkUrl'] != null ? map['linkUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TextModel(text: $text, isHyperlink: $isHyperlink, maxLines: $maxLines, format: $format, style: $style, linkUrl: $linkUrl, onTap: $onTap)';
  }

  @override
  bool operator ==(covariant TextModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.isHyperlink == isHyperlink &&
        other.maxLines == maxLines &&
        other.format == format &&
        other.style == style &&
        other.linkUrl == linkUrl &&
        other.onTap == onTap;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        isHyperlink.hashCode ^
        maxLines.hashCode ^
        format.hashCode ^
        style.hashCode ^
        linkUrl.hashCode ^
        onTap.hashCode;
  }
}

class RichTextWidget extends StatelessWidget {
  final List<TextModel> texts;
  final int maxLines;
  final TextAlign? alignment;

  const RichTextWidget(
      {Key? key,
      required this.texts,
      required this.maxLines,
      this.alignment = TextAlign.start})
      : super(key: key);
  factory RichTextWidget.fromMap(Map<String, dynamic> map) {
    return RichTextWidget(
        maxLines: map['maxLines'],
        texts: List<TextModel>.from(
            map["richText"].map((x) => TextModel.fromMap(x))),
        alignment:
            map['textAlign'] != null ? getTextAlign(map['textAlign']) : null);
  }
  @override
  Widget build(BuildContext context) {
    return richText(
      texts: texts,
      maxLines: maxLines,
      alignment: alignment ?? TextAlign.start,
    );
  }
}

Widget richText(
    {required List<TextModel> texts,
    int maxLines = 2,
    TextAlign alignment = TextAlign.start}) {
  return Text.rich(
    style: const TextStyle(fontFamily: 'DM Sans'),
    TextSpan(children: <TextSpan>[
      for (var text in texts)
        TextSpan(
          recognizer: (TapGestureRecognizer()
            ..onTap = () async {
              if (text.linkUrl != null) {
                await launch(text.linkUrl ?? '');
              }

              // if (text.onTap != null) {
              //   text.onTap!();
              //   return;
              // }
            }),
          text: text.text,
          style: text.style,
        ),
    ]),
    textAlign: alignment,
    maxLines: maxLines,
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
