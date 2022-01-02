import 'package:dio/dio.dart';
import 'package:tomato_market/constants/common_size.dart';
import 'package:tomato_market/data/address_model.dart';
import 'package:tomato_market/utils/logger.dart';

class AddressService {
  Future<AddressModel> searchAddressByStr(String text) async {
    final formData = {
      'key': vworldKey,
      'request': 'search',
      'size': 30,
      'query': text,
      'type': 'ADDRESS',
      'category': 'ROAD',
      '': '',
    };
    final response = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    AddressModel addressModel =
        AddressModel.fromJson(response.data['response']);
    // logger.d(addressModel);
    return addressModel;
  }
}
