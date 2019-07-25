/**
 * @user Huai
 * @date 2019-06-21 12:02
 * 正则表达式工具类
 */
class RegExpUtil {
  static final RegExp _phoneRegExp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

  /*
   * 匹配手机号
   */
  static isValidPhone(String phone) {
    return _phoneRegExp.hasMatch(phone);
  }

  static final _urlRegExp = new RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");
  /*
   * 匹配网址
   */
  static isValidUrl(String url){
    return _urlRegExp.hasMatch(url);
  }

  static final _identityRegExp = new RegExp(r"\d{17}[\d|x]|\d{15}");
  /*
   * 匹配身份证号码
   */
  static isValidIdentity(String identity) {
    return _identityRegExp.hasMatch(identity);
  }

  ///********以下为项目密码、验证码等特有规则验证********///
  static final _passwordRegExp = new RegExp(r'^.{6,12}$'); // 限制密码为6-12位
  /*
   * 验证密码 目前限制为6-20个字符为合法
   */
  static isValidPassword(String password){
    print(_passwordRegExp.hasMatch(password));
    return _passwordRegExp.hasMatch(password);
  }

  static final _verCodeRegExp = new RegExp(r'^.{4}$');

  static isValidVerCode(String vercode){
    print(_verCodeRegExp.hasMatch(vercode));
    return _verCodeRegExp.hasMatch(vercode);
  }

}
