import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

/**
 * created by Huai 2019/4/15 0015
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mz_flutterapp_deep/data/apis/apis.dart';
import 'package:mz_flutterapp_deep/data/net/dio_util.dart';
import 'package:mz_flutterapp_deep/utils/local_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:mz_flutterapp_deep/db/sys_common_config.dart';
import 'package:intl/intl.dart';

/// AppStore
const APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';

/// 谷歌商店
const PLAY_STORE_URL = "http://www.meng-zheng.com.cn/download/deep.apk";
// 'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

Future<bool> versionCheck(context) async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  var versionList;

  DateTime now = DateTime.now();
  DateTime time = now.add(new Duration(days: 7));

  SysSettingProvider SysSQLite = new SysSettingProvider();
  await SysSQLite.open();
  SysSetting sysSetting = await SysSQLite.getSetting();
  var formatter = new DateFormat('yyyy-MM-dd');

  SysSetting newSetting = SysSetting.fromMap({
    columnId: 1,
    columnGuid: "admin_sys_guid",
    columnShowUpdate: 1,
    columnExpiredTime: formatter.format(time),
  });

  if (sysSetting == null) {
    // 首次记录
    await SysSQLite.insert(newSetting);
    SysSetting sys = await SysSQLite.getSetting();
  } else {
    // 与当前时间作比较
    DateTime expiredTime = DateTime.parse(sysSetting.expiredTime);
    if (now.isBefore(expiredTime)) {
      // 未过期则跳过
//      return null;
    } else {
      //更新时间
      await SysSQLite.update(newSetting);
    }
  }

  try {
    versionList =
        await NetUtils.get("${NetUtils.host + DeepApi.API_VERSION}", {});

    /// 版本检测
    var versionInfo = json.decode(versionList);

    print(
        "******************************* VERSION CHECK ************************");
    print(
        "                          当前系统版本号：$currentVersion                  ");
    print(
        "                          最新系统版本号：${versionInfo[0]["lastVersion"]}      ");
    print(
        "                          最低系统版本号：${versionInfo[0]["minSupportVersion"]}      ");
    print(
        "******************************* VERSION CHECK ************************");

    var newVersion = double.parse(
        versionInfo[0]["lastVersion"].toString().trim().replaceAll(".", ""));
    if (double.parse(versionInfo[0]["minSupportVersion"]) < currentVersion) {
      _showVersionDialog(context, versionInfo[0], currentVersion);
    } else if (newVersion > currentVersion &&
        LocalStorage.get("updateVersionAfter") != null) {
      _showVersionDialog(context, versionInfo[0], currentVersion);
    }
  } catch (e) {
    print(e);
    return false;
  }
  return false;
}

_showVersionDialog(
    BuildContext context, checkInfo, double currentVersion) async {
  await showDialog<String>(
    context: context,
    builder: (_) {
      String title = "发现新版本";
      String message = "目前有新版本.";
      String btnLabel = "现在更新";
      String btnLabelCancel = "以后再说";

      return FlareGiffyDialog(
        flarePath: 'assets/images/background/space_img.flr',
        flareAnimation: 'loading',
        buttonOkText: Text(
          btnLabel,
          style: TextStyle(color: Colors.white),
        ),
        buttonCancelText: Text(
          btnLabelCancel,
          style: TextStyle(color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        onOkButtonPressed: () {
          Platform.isIOS
              ? _launchURL(APP_STORE_URL)
              : _launchURL(PLAY_STORE_URL);
        },
        onCancelButtonPressed: () async {
          /// 此处需判断是否需要强制
          if (double.parse(checkInfo["minSupportVersion"]) > currentVersion) {
            await pop();
          } else {
            LocalStorage.save("updateVersionAfter", "1");
          }
        },
      );
    },
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw '$url 加载失败！请稍候重试。';
  }
}

Future<void> pop() async {
  await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
