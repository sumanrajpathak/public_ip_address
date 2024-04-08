import 'package:mocktail/mocktail.dart';
import 'package:public_ip_address/public_ip_address.dart';
import 'package:public_ip_address/src/ip_repository.dart';
import 'package:test/test.dart';

import '../data.dart';

class MockRepository extends Mock implements IpRepository {}

void main() {
  late MockRepository repository;
  setUpAll(() async {
    repository = MockRepository();
  });
  group('IpAddress -', () {
    test("test getAllData", () async {
      when(() => repository.getAllData()).thenAnswer((_) async => geoIpJson);
      Map<String, dynamic> data = await repository.getAllData();
      expect(data, isNotNull);
      expect(data, geoIpJson);
    });
    test("getAllDataFor", () async {
      when(() => repository.getAllDataFor(testIP))
          .thenAnswer((_) async => geoIpJson);
      Map<String, dynamic> jsonData = await repository.getAllDataFor(testIP);
      expect(jsonData, isNotNull);
      expect(jsonData, geoIpJson);
    });
    test("getAsn", () async {
      when(() => repository.getAsn()).thenAnswer((_) async => geoIpJson["asn"]);
      int asn = await repository.getAsn();
      expect(asn, isNotNull);
      expect(asn, isA<int>());
      expect(asn, geoIpJson["asn"]);
    });
    test("getAsnFor", () async {
      when(() => repository.getAsnFor(geoIpJson["ip"]))
          .thenAnswer((_) async => geoIpJson["asn"]);
      int asn = await repository.getAsnFor(geoIpJson["ip"]);
      expect(asn, isNotNull);
      expect(asn, geoIpJson["asn"]);
    });
    test("getCity", () async {
      when(() => repository.getCity())
          .thenAnswer((_) async => geoIpJson["city"]);
      String city = await repository.getCity();
      expect(city, isNotNull);
      expect(city, geoIpJson["city"]);
    });
    test("getCityFor", () async {
      when(() => repository.getCityFor(geoIpJson["ip"]))
          .thenAnswer((_) async => geoIpJson["city"]);
      String city = await repository.getCityFor(geoIpJson["ip"]);
      expect(city, isNotNull);
      expect(city, geoIpJson["city"]);
    });

    test("getContinentCode", () async {
      when(() => repository.getContinentCode())
          .thenAnswer((_) async => geoIpJson["continent_code"]);
      String continentCode = await repository.getContinentCode();
      expect(continentCode, isNotNull);
      expect(continentCode, geoIpJson["continent_code"]);
    });
    test("getContinentCodeFor", () async {
      when(() => repository.getContinentCodeFor(geoIpJson["ip"]))
          .thenAnswer((_) async => geoIpJson["continent_code"]);
      String continentCode = await repository.getContinentCodeFor(geoIpJson["ip"]);
      expect(continentCode, isNotNull);
      expect(continentCode, geoIpJson["continent_code"]);
    });
    test("getCountry", () async {
      when(() => repository.getCountry())
          .thenAnswer((_) async => geoIpJson["country"]);
      String country = await repository.getCountry();
      expect(country, isNotNull);
      expect(country, geoIpJson["country"]);
    });
    test("getCountryCode", () async {
      when(() => repository.getCountryCode())
          .thenAnswer((_) async => geoIpJson["country_code"]);
      String countryCode = await repository.getCountryCode();
      expect(countryCode, isNotNull);
      expect(countryCode, geoIpJson["country_code"]);
    });
    test("getCountryCode3", () async {
      when(() => repository.getCountryCode3())
          .thenAnswer((_) async => geoIpJson["country_code3"]);
      String countryCode3 = await repository.getCountryCode3();
      expect(countryCode3, isNotNull);
      expect(countryCode3, geoIpJson["country_code3"]);
    });
    test("getCountryCode3For", () async {
      when(() => repository.getCountryCode3For(geoIpJson["ip"]))
          .thenAnswer((_) async => geoIpJson["country_code3"]);
      String countryCode3 = await repository.getCountryCode3For(geoIpJson["ip"]);
      expect(countryCode3, isNotNull);
      expect(countryCode3, geoIpJson["country_code3"]);
    });
    test("getCountryCodeFor", () async {
      when(() => repository.getCountryCodeFor(geoIpJson["ip"]))
          .thenAnswer((_) async => geoIpJson["country_code"]);
      String countryCode = await repository.getCountryCodeFor(geoIpJson["ip"]);
      expect(countryCode, isNotNull);
      expect(countryCode, geoIpJson["country_code"]);
    });
    test("getCountryFor", () async {
      when(() => repository.getCountryFor(geoIpJson["ip"]))
          .thenAnswer((_) async => geoIpJson["country"]);
      String country = await repository.getCountryFor(geoIpJson["ip"]);
      expect(country, isNotNull);
      expect(country, geoIpJson["country"]);
    });
    
    test("getSeeIp", () async {
      when(() => repository.getSeeIp("ip")).thenAnswer((_) async => testIP);
      String ip = await repository.getSeeIp("ip");
      expect(ip, isNotNull);
      expect(ip, testIP);
    });

    test("getIP", () async {
      when(() => repository.getIp(version: Ip.v4))
          .thenAnswer((_) async => testIP);
      String ip = await repository.getIp();
      expect(ip, isNotNull);
      expect(ip, testIP);
    });
    test("getIpv4", () async {
      when(() => repository.getIpv4()).thenAnswer((_) async => testIP);
      String ip = await repository.getIpv4();
      expect(ip, isNotNull);
      expect(ip, testIP);
    });
    test("getIpv6", () async {
      when(() => repository.getIpv6()).thenAnswer((_) async => testIPV6);
      String ip = await repository.getIpv6();
      expect(ip, isNotNull);
      expect(ip, testIPV6);
    });
  });
}
