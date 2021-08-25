

import 'package:funda_sample/data/models/responses/house.dart';
import 'package:funda_sample/utils/network/network_service.dart';

class HouseRepository
{
  HouseRepository({required this.networkService,});

  final NetworkService networkService;
  static const BASE_URL = 'https://partnerapi.funda.nl/feeds/Aanbod.svc/json/';

  static const GET_HOUSE_DETAILS = '/detail/{key}/koop/{id}/';
  Future<HouseResponseModel> fetchHouseDetails(String key,String id)
  async {
    var response = await networkService.get(url: BASE_URL+GET_HOUSE_DETAILS.replaceAll('{key}', key).replaceAll('{id}', id), headers: {});
    HouseResponseModel houseResponseModel =
    houseResponseModelFromJson(response.body);
    return houseResponseModel;
  }

}