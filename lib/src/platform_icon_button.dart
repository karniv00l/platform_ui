import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformIconButton extends StatelessWidget with PlatformMixin<Widget> {
  final double? iconSize;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final double? splashRadius;
  final Widget icon;
  final Color? hoverColor;
  final Color? disabledColor;
  final VoidCallback? onPressed;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final BoxConstraints? constraints;
  final Color? backgroundColor;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final FluentUI.IconButtonMode windowsIconButtonMode;

  const PlatformIconButton({
    required this.icon,
    required this.onPressed,
    this.iconSize,
    this.visualDensity,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    this.splashRadius,
    this.hoverColor,
    this.disabledColor,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.constraints,
    this.backgroundColor,
    this.shape,
    this.borderRadius,
    this.windowsIconButtonMode = FluentUI.IconButtonMode.large,
    Key? key,
  }) : super(key: key);

  @override
  Widget android(context) {
    return IconButton(
      iconSize: iconSize,
      visualDensity: visualDensity,
      padding: padding,
      alignment: alignment,
      splashRadius: splashRadius,
      icon: icon,
      hoverColor: hoverColor,
      disabledColor: disabledColor,
      onPressed: onPressed,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      constraints: constraints,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        shape: MaterialStateProperty.all(
          shape == BoxShape.rectangle
              ? RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(8.0),
                )
              : const CircleBorder(),
        ),
      ),
    );
  }

  @override
  Widget ios(context) {
    final cupertinoButton = CupertinoButton(
      alignment: alignment,
      onPressed: onPressed,
      borderRadius: borderRadius,
      disabledColor: disabledColor ?? CupertinoColors.quaternarySystemFill,
      minSize: iconSize,
      padding: padding,
      child: icon,
    );
    return Focus(
      autofocus: autofocus,
      focusNode: focusNode,
      child: MouseRegion(
        cursor: mouseCursor ?? MouseCursor.defer,
        child: constraints != null
            ? ConstrainedBox(
                constraints: constraints!,
                child: cupertinoButton,
              )
            : cupertinoButton,
      ),
    );
  }

  @override
  Widget linux(context) {
    return android(context);
  }

  @override
  Widget macos(context) {
    return Focus(
      focusNode: focusNode,
      autofocus: autofocus,
      child: MacosTooltip(
        message: tooltip ?? '',
        child: MacosIconButton(
          padding: padding,
          alignment: alignment,
          icon: icon,
          hoverColor: hoverColor,
          disabledColor: disabledColor,
          onPressed: onPressed,
          mouseCursor: mouseCursor ?? MouseCursor.defer,
          boxConstraints: constraints ??
              const BoxConstraints(
                minHeight: 20,
                minWidth: 20,
                maxWidth: 30,
                maxHeight: 30,
              ),
          backgroundColor: backgroundColor,
          shape: shape ?? BoxShape.rectangle,
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  @override
  Widget windows(context) {
    return Align(
      alignment: alignment,
      child: FluentUI.Tooltip(
        message: tooltip ?? '',
        child: FluentUI.IconButton(
          icon: icon,
          onPressed: onPressed,
          autofocus: autofocus,
          focusNode: focusNode,
          iconButtonMode: windowsIconButtonMode,
          style: FluentUI.ButtonStyle(
            backgroundColor: backgroundColor != null
                ? FluentUI.ButtonState.all(backgroundColor)
                : null,
            iconSize:
                iconSize != null ? FluentUI.ButtonState.all(iconSize) : null,
            padding: FluentUI.ButtonState.all(padding),
            shape: FluentUI.ButtonState.all(
              shape == BoxShape.rectangle
                  ? FluentUI.RoundedRectangleBorder(
                      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
                    )
                  : const FluentUI.CircleBorder(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }
}