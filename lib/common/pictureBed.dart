import 'package:dio/dio.dart';//引入dio.dart

Future pictureBed(String methods, String api,FormData obj)async{

  //注意：请求参数的数据类型是Map，数据结构类型是key为String，value可以是任意类型dynamic
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = "http://39.97.250.157:7003/";
    dio.options.connectTimeout = 5000;//链接超时，单位毫秒
    dio.options.receiveTimeout = 3000;//接收超时，单位毫秒

    // 更换ContentType
    // dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.responseType = ResponseType.json;//定制接收的数据类型
    dio.options.headers = {
      'Accept':'application/json, text/plain, */*',
      'Content-Type':'application/json',
      'Authorization':"**",
      'User-Aagent':"4.1.0;android;6.0.1;default;A001",
      "HZUID":"2",
    };
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
    response = await dio.post<String>(api, data: obj);
    return response;//返回请求结果
  } catch (e) {
    print('报错$e');
    return e;
  }
}
