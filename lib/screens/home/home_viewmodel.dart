import 'package:flutter/material.dart';
import 'package:funda_sample/data/models/responses/house.dart';
import 'package:funda_sample/data/repository/remote/house_repository.dart';
import 'package:funda_sample/resources/constants.dart';
import 'package:funda_sample/utils/network/network_service.dart';
import 'package:funda_sample/utils/network/response_provider.dart';

class HomeViewModel with ChangeNotifier {

  static const key= CONSTANT_KEY;
  static const id = CONSTANT_ID;

  HouseRepository _houseRepository = HouseRepository(networkService: NetworkService());
  ResponseProvider _responseProvider = ResponseProvider.loading('Fetching artist data');

  HouseResponseModel? _houseResponseModel;

  ResponseProvider get responseProvider {
    return _responseProvider;
  }

  HouseResponseModel? get houseResponseModel {
    return _houseResponseModel;
  }

  Future<void> fetchHouseDetails() async {
    try {
      HouseResponseModel? houseResponseModel = await _houseRepository.fetchHouseDetails(key,id);
      _houseResponseModel = houseResponseModel;
      _responseProvider = ResponseProvider.completed(houseResponseModel);
    } catch (e) {
      _responseProvider = ResponseProvider.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}