import 'package:dio/dio.dart';

abstract class IHttpClient{
  Future get({required String url});
}

class HttpClient implements IHttpClient{
  final Dio _dio = Dio();

  @override
  Future get({required String url}) async{
    return await _dio.get(url);
    
    // // TODO: implement get
    // throw UnimplementedError();
  }
  
}