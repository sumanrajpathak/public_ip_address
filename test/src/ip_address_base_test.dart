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
