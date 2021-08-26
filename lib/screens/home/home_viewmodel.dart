import 'package:flutter/material.dart';
import 'package:funda_sample/data/models/responses/house.dart';
import 'package:funda_sample/data/repository/remote/house_repository.dart';
import 'package:funda_sample/resources/constants.dart';
import 'package:funda_sample/utils/network/response_provider.dart';

class HomeViewModel with ChangeNotifier {
  HouseRepository houseRepository;
  HomeViewModel({required this.houseRepository});

  var key= CONSTANT_KEY;
  var id = CONSTANT_ID;

  ResponseProvider<HouseResponseModel> _houseDetailsFetchResponse = ResponseProvider.initial('');

  ValueNotifier<int> currentPhotoIndex = ValueNotifier(0);

  Future<void> fetchHouseDetails() async {
    _houseDetailsFetchResponse = ResponseProvider.loading('Fetching house details data...');
    notifyListeners();
    try {
      HouseResponseModel? houseResponseModel = await houseRepository.fetchHouseDetails(key,id);
      _houseDetailsFetchResponse = ResponseProvider.completed(houseResponseModel);
    } catch (e) {
      _houseDetailsFetchResponse = ResponseProvider.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  ResponseProvider<HouseResponseModel> get houseDetails {
    return _houseDetailsFetchResponse;
  }

}