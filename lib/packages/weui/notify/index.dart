import 'dart:async';
import 'package:flutter/material.dart';
import './notify.dart';
import '../utils.dart';
import '../theme/index.dart';

typedef _Notify = Function ({
  int duration,
  Function() onColse,
  @required Widget child
});

typedef _Show = Function ({
  Color color,
  int duration,
  // 取消删除地址时触发
  Function() onColse,
  @required Widget child
});

class WeNotify {
  // 成功
  static _Notify success (BuildContext context) {
    final int notifySuccessDuration = WeUi.getConfig(context).notifySuccessDuration;
    return ({ duration, child, onColse }) {
      WeNotify.show(context)(
        color: WeUi.getTheme(context).primaryColor,
        duration: duration == null ? notifySuccessDuration : duration,
        child: child,
        onColse: onColse
      );
    };
  }

  // 失败
  static error (BuildContext context) {
    final int notifyErrorDuration = WeUi.getConfig(context).notifyErrorDuration;
    return ({ duration, child, onColse }) {
      WeNotify.show(context)(
        color: WeUi.getTheme(context).warnColor,
        duration: duration == null ? notifyErrorDuration : duration,
        child: child,
        onColse:onColse,
      );
    };
  }

  static _Show show (BuildContext context) {
    final int notifyDuration = WeUi.getConfig(context).notifyDuration;
    return ({ color, duration, child, onColse }) {
      final GlobalKey widgetKey = GlobalKey();
      final Function remove = createOverlayEntry(
        context: context,
        child: NotifyWidget(
          key: widgetKey,
          color: color == null ? WeUi.getTheme(context).warnColor : color,
          child: child
        )
      );

      void close() async {
        // 反向执行动画
        await (widgetKey.currentState as NotifyWidgetState).reverseAnimation();
        if (onColse != null) onColse();
        remove();
      }

      Future.delayed(Duration(milliseconds: duration == null ? notifyDuration : duration), close);
    };
  }
}