import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:funda_sample/data/repository/remote/house_repository.dart';
import 'package:funda_sample/resources/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:funda_sample/data/models/responses/house.dart';

import 'home_viewmodel_test.mocks.dart';


@GenerateMocks([HouseRepository])
void main() {
  group('fetchHouseDetails', () {

    test('returns house details if repository get data back successfully', () async {
      final mockHouseRepository = MockHouseRepository();

      final key = CONSTANT_KEY;
      final id = CONSTANT_ID;
      final file = new File('test_resources/house_response_mock.json');
      final jsonResponse = await file.readAsString();

      when(mockHouseRepository.fetchHouseDetails(key, id))
          .thenAnswer((_) async =>houseResponseModelFromJson(jsonResponse));

      var response = await mockHouseRepository.fetchHouseDetails(key, id);
      expect(response, isA<HouseResponseModel>());
    });

    test('throws an exception if the wrong key and id sends to the fetch function', () async {
      final mockHouseRepository = MockHouseRepository();

      final key = '';
      final id = '';

      when(mockHouseRepository.fetchHouseDetails(key, id))
          .thenThrow(Exception('failed to get data'));

      expect(() async => await mockHouseRepository.fetchHouseDetails(key, id), throwsException);
    });
  });
}