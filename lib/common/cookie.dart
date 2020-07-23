import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';

class Api {  
  static final CookieJar cookieJar = new CookieJar();
  static final url = 'http://192.168.219.1:7008';
  static saveCookie(List<Cookie> cookies) {
    cookieJar.saveFromResponse(Uri.parse(url), cookies);
  }
  static List<Cookie> getCookie() {
    return cookieJar.loadForRequest(Uri.parse(url));
  }
}
