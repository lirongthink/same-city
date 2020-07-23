import 'package:dio/dio.dart';//引入dio.dart

import 'dart:io';

import 'package:same_city/common/cookie.dart';//引入dart的基本库io提供对I/O的支持

Future https(String methods, String api,Map<String,dynamic> obj)async{
  print('显示参数，方式$methods,接口$api ,参数$obj');

  //注意：请求参数的数据类型是Map，数据结构类型是key为String，value可以是任意类型dynamic
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = "http://192.168.0.100:7008/";
    dio.options.connectTimeout = 5000;//链接超时，单位毫秒
    dio.options.receiveTimeout = 3000;//接收超时，单位毫秒

    // 更换ContentType
    // dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.responseType = ResponseType.json;//定制接收的数据类型
    if(api != 'userLogin' && api != 'register'){
      //添加header头
      List<Cookie> cookies = Api.getCookie();
      print(cookies[0].value);
      dio.options.headers = {
        "token": cookies[0].value,
      };
    }
    //这里是请求拦截
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options){
        print(options.contentType);

        // Do something before request is sent
        return options; //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)` 
      },

      onResponse:(Response response) {
      // Do something with response data
        return response; // continue
      },
      onError: (DioError e) {
      // Do something with response error
        return e;//continue
      }
    ));

    // 判断请求的方式调用dio不同的请求api
    if(methods == "post"){
      response = await dio.post(api, data: obj);
    }else if(methods == 'get'){
      response = await dio.get(api, queryParameters: obj);
    }else if(methods == 'delete'){
      response = await dio.delete(api);
    }
    //注意get请求使用queryParameters接收参数，post请求使用data接收参数
    return response;//返回请求结果
  } catch (e) {
    print('报错$e');
    return e;
  }
}
