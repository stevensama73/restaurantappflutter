import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app2/data/model/detail_restaurant.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/data/model/review_restaurant.dart';
import 'package:restaurant_app2/data/model/search_restaurant.dart';
import 'dummy_api_service.dart';
import 'fetch_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('API Test', () {
    final client = MockClient();
    late DummyApiService dummyApiService;
    late ReviewRestaurant reviewRestaurant;

    setUp(() {
      dummyApiService = DummyApiService(client);
      reviewRestaurant = ReviewRestaurant(id: 'rqdv5juczeskfw1e867', name: 'xx', review: 'xxxxxx');
    });

    test('return a RestaurantResult success if the http call completes successfully', () async {
      when(client.get(Uri.parse(dummyApiService.baseUrl + 'list')))
          .thenAnswer((_) async => http.Response('''
          {
              "error": false,
              "message": "success",
              "count": 20,
              "restaurants": [
                {
                    "id": "rqdv5juczeskfw1e867",
                    "name": "Melting Pot",
                    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                    "pictureId": "14",
                    "city": "Medan",
                    "rating": 4.2
                }
              ]
          }
          ''', 200));

      expect(await dummyApiService.listRestaurants(), isA<RestaurantResult>());
    });

    test('throws an exception of RestaurantResult if the http call completes with an error', () async {
      when(client.get(Uri.parse(dummyApiService.baseUrl + 'list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(dummyApiService.listRestaurants(), throwsException);
    });

    test('return a DetailRestaurantResult success if the http call completes successfully', () async {
      String id = 'rqdv5juczeskfw1e867';

      when(client.get(Uri.parse(dummyApiService.baseUrl + 'detail/$id')))
          .thenAnswer((_) async => http.Response('''
          {
              "error": false,
              "message": "success",
              "restaurant": {
                  "id": "rqdv5juczeskfw1e867",
                  "name": "Melting Pot",
                  "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                  "city": "Medan",
                  "address": "Jln. Pandeglang no 19",
                  "pictureId": "14",
                  "categories": [
                      {
                          "name": "Italia"
                      },
                      {
                          "name": "Modern"
                      }
                  ],
                  "menus": {
                      "foods": [
                          {
                              "name": "Paket rosemary"
                          },
                          {
                              "name": "Toastie salmon"
                          }
                      ],
                      "drinks": [
                          {
                              "name": "Es krim"
                          },
                          {
                              "name": "Sirup"
                          }
                      ]
                  },
                  "rating": 4.2,
                  "customerReviews": [
                      {
                          "name": "Ahmad",
                          "review": "Tidak rekomendasi untuk pelajar!",
                          "date": "13 November 2019"
                      }
                  ]
              }
          }
          ''', 200));

      expect(await dummyApiService.detailRestaurant(id), isA<DetailRestaurantResult>());
    });

    test('throws an exception of DetailRestaurantResult if the http call completes with an error', () async {
      String id = 'rqdv5juczeskfw1e867';
      
      when(client.get(Uri.parse(dummyApiService.baseUrl + 'detail/$id')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(dummyApiService.detailRestaurant(id), throwsException);
    });

    test('return a statusCode of Post Review if the http call completes successfully', () async {
      when(client.post(Uri.parse(dummyApiService.baseUrl + 'review'), body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('''
          {
              "error": false,
              "message": "success",
              "customerReviews": [
                  {
                      "name": "Ahmad",
                      "review": "Tidak rekomendasi untuk pelajar!",
                      "date": "13 November 2019"
                  },
                  {
                      "name": "test",
                      "review": "makanannya lezat",
                      "date": "29 Oktober 2020"
                  }
              ]
          }
          ''', 200));

      expect(await dummyApiService.reviewRestaurant(reviewRestaurant).then((value) => value.statusCode), 200);
    });

    test('return a statusCode of Post Review if the http call completes with an error', () async {
      when(client.post(Uri.parse(dummyApiService.baseUrl + 'review'), body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(await dummyApiService.reviewRestaurant(reviewRestaurant).then((value) => value.statusCode), 404);
    });

    test('return a SearchRestaurantResult success if the http call completes successfully', () async {
      String query = 'makan';

      when(client.get(Uri.parse(dummyApiService.baseUrl + 'search?q=$query')))
          .thenAnswer((_) async => http.Response('''
          {
              "error": false,
              "founded": 1,
              "restaurants": [
                  {
                      "id": "fnfn8mytkpmkfw1e867",
                      "name": "Makan mudah",
                      "description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
                      "pictureId": "22",
                      "city": "Medan",
                      "rating": 3.7
                  }
              ]
          }
          ''', 200));

      expect(await dummyApiService.searchRestaurants(query), isA<SearchRestaurantResult>());
    });

    test('throws an exception of SearchRestaurantResult if the http call completes with an error', () async {
      String query = 'makan';

      when(client.get(Uri.parse(dummyApiService.baseUrl + 'search?q=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(dummyApiService.searchRestaurants(query), throwsException);
    });
  });
}