import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:funda_sample/data/models/responses/house.dart';
import 'package:funda_sample/data/repository/remote/house_repository.dart';
import 'package:funda_sample/resources/constants.dart';
import 'package:funda_sample/utils/network/network_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'house_repository_test.mocks.dart';


@GenerateMocks([NetworkService])
void main() {
  group('fetchHouseDetails', () {

    test('returns house details if the http call completes successfully', () async {
      final mockNetworkService = MockNetworkService();

      final key = CONSTANT_KEY;
      final id = CONSTANT_ID;
      final url = HouseRepository.BASE_URL+HouseRepository.GET_HOUSE_DETAILS.replaceAll('{key}', key).replaceAll('{id}', id);
      final file = new File('test_resources/house_response_mock.json');
      final jsonResponse = await file.readAsString();

      when(mockNetworkService
          .get(url:url,headers: {}))
          .thenAnswer((_) async =>
          http.Response(jsonResponse, 200,headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      expect(await HouseRepository(networkService: mockNetworkService).fetchHouseDetails(key,id), isA<HouseResponseModel>());
    });

    test('throws an exception if the wrong key and id sends to the endpoint', () async {
      final mockNetworkService = MockNetworkService();

      final key = '';
      final id = '';
      final url = HouseRepository.BASE_URL+HouseRepository.GET_HOUSE_DETAILS.replaceAll('{key}', key).replaceAll('{id}', id);

      when(mockNetworkService
          .get(url:url,headers: {}))
          .thenAnswer((_) async =>
          http.Response('Not Found', 404));

      expect(() async => await HouseRepository(networkService: mockNetworkService).fetchHouseDetails(key,id), throwsException);
    });
  });
}