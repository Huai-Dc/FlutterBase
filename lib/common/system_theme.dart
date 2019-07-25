/**
 * @user Huai
 * @date 2019-07-11 15:51
 *
 * 透明度 16 进制对照
 * 100% - FF  95% - F2  90% - E6  85% - D9  80% — CC  75% — BF  70% — B3
 * 65% — A6 60% — 99  55% — 8C  50% — 80  45% — 73  40% — 66  35% — 59
 * 30% — 4D 25% — 40  20% — 33  15% — 26  10% — 1A  5% — 0D 0% — 00
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SystemTheme{
  SystemTheme._();

  /// 系统主色
  static const Color app_main = Color(0xFF06C7B8);
  static const Color app_main_disable = Color(0xFF82e3db);

  /// 页面标题颜色
  /// 主要文字 正文
  static const Color text_dark = Color(0xFF333333);
  /// 辅助文字 提示文字 失效颜色
  static const Color text_gray = Color(0xFF7d7d7d);

  /// 链接色
  static const Color text_link = Color(0xFF06C7B8);

  /// 成功色
  static const Color text_success = Color(0xFF52c41a);

  /// 警告色
  static const Color text_warn = Color(0xFFfaad14);

  /// 错误色
  static const Color text_error = Color(0xFFf5222d);

  /// 边框色
  static const Color border_color_base = Color(0xFFD2D2D2);

  /// toast 背景色
  static const Color background_color_toast = Color(0x80000000);

  /// 背景色
  static const Color back_color = Color(0xfff5f6f9);

  /// **********************************************************
  /// 以下为系统字体
  /// 目前只有粗体和细体
  /// **********************************************************

  /// 边框色
  static const String cNLight = "CNLight";

  /// 背景色
  static const String cNMedium = "CNMedium";

  /// **********************************************************
  /// 以下为系统主要字体大小
  /// 新增请严格按照格式 fontSize_{字号}
  /// **********************************************************

  /// 主标题文字
  static double fontSize_32 = ScreenUtil().setSp(32);

  /// 一级标题
  static double fontSize_30 = ScreenUtil().setSp(30);

  /// 主要文字、正文
  static double fontSize_28 = ScreenUtil().setSp(28);

  /// 辅助文字、提示文字
  static double fontSize_24 = ScreenUtil().setSp(24);

  /// 次要提示文字
  static double fontSize_22 = ScreenUtil().setSp(22);

  /// 迷你文字
  static double fontSize_20 = ScreenUtil().setSp(20);

  /// **********************************************************
  /// 以下为系统页面一些边距大小规格
  /// **********************************************************

  /// 边距
  static double width_space_24 = ScreenUtil().setWidth(24);

  static double width_space_30 = ScreenUtil().setWidth(30);

  /// 页面主体内容 宽度
  static double width_body_620 = ScreenUtil().setWidth(620);

  static double width_body_609 = ScreenUtil().setWidth(690);

  static double width_body_702 = ScreenUtil().setWidth(702);


  /// **********************************************************
  /// 部分通用内容样式
  /// **********************************************************

  /// 标题通用 字体样式
  static TextStyle appBar_title_style = new TextStyle(
    fontSize: ScreenUtil().setSp(34),
    color: Color(0xff333333),
    fontWeight: FontWeight.bold,
    fontFamily: "PingFang-SC-Bold",
  );

  /// 标题栏 高度
  static Size appBarHeight = Size.fromHeight(ScreenUtil().setWidth(100));

}