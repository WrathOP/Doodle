import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

extension StringExt on String {
  String get routeName {
    if (this == '/') return this;
    if (startsWith('/')) return split('/').last;

    return this;
  }
}

extension ListExt on List<Object> {
  int get lastIndex => length - 1;
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Brightness get brightness => theme.brightness;
  TextTheme get textTheme => theme.textTheme;
  Color? get textColor => theme.textTheme.bodyMedium?.color;
  Size get screenSize => MediaQuery.sizeOf(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get edgeInset => MediaQuery.viewPaddingOf(this);
  AppLocalizations get loc => AppLocalizations.of(this);
  ThemeMode get themeMode =>
      theme.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;

  ButtonStyle get iconButtonStyle => IconButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      );

  Future<Color?> showColorPicker(Color? prevColor) {
    return showDialog<Color>(
      context: this,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: Config.h(8),
            spacing: Config.h(8),
            children: Constants.allColors
                .map(
                  (color) => GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: Config.h(15),
                          backgroundColor: color,
                        ),
                        if (prevColor == color) ...[
                          Icon(
                            AppIcons.check,
                            color: Colors.white,
                            size: Config.h(16),
                          ),
                        ],
                      ],
                    ),
                    onTap: () => context.pop(color),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
