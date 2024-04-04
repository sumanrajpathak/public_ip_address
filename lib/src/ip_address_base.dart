import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:public_ip_address/src/ip_repository.dart';

enum Ip { v4, v6 }

class IpAddress extends IpRepository {
  @override
  Future<Map<String, dynamic>> getAllData({Ip version = Ip.v4}) async {
    try {
      Map<String, dynamic> _json = jsonDecode((await http.get(Uri.parse(
              'https://ip${version == Ip.v4 ? 'v4' : 'v6'}.seeip.org/geoip')))
          .body);
      return {
        'ip': _json['ip'],
        'continentCode': _json['continent_code'],
        'country': _json['country'],
        'countryCode': _json['country_code'],
        'countryCode3': _json['country_code3'],
        'latitude': _json['latitude'],
        'longitude': _json['longitude'],
        'timeZone': _json['timezone'],
        'offset': _json['offset'],
        'asn': _json['asn'],
        if (_json['organization'] != null)
          'organization': _json['organization'],
        if (_json['region'] != null) 'region': _json['region'],
        if (_json['region_code'] != null) 'regionCode': _json['region_code'],
        if (_json['city'] != null) 'region': _json['region'],
        if (_json['postal_code'] != null) 'postal_code': _json['postal_code'],
      };
    } on Exception catch (e) {
      if (e.toString().contains('SocketException')) {
        return {'error': 'Internet Error'};
      } else {
        return {'error': e.toString()};
      }
    }
  }

  @override
  Future<Map<String, dynamic>> getAllDataFor(String ip) async {
    try {
      Map _json = jsonDecode(
          (await http.get(Uri.parse('https://api.seeip.org/geoip/$ip'))).body);
      if (_json.containsKey('ip')) {
        return {
          'continentCode': _json['continent_code'],
          'country': _json['country'],
          'countryCode': _json['country_code'],
          'countryCode3': _json['country_code3'],
          'latitude': _json['latitude'],
          'longitude': _json['longitude'],
          'timeZone': _json['timezone'],
          'offset': _json['offset'],
          'asn': _json['asn'],
          if (_json['organization'] != null)
            'organization': _json['organization'],
          if (_json['region'] != null) 'region': _json['region'],
          if (_json['region_code'] != null) 'regionCode': _json['region_code'],
          if (_json['city'] != null) 'region': _json['region'],
          if (_json['postal_code'] != null) 'postal_code': _json['postal_code'],
        };
      } else {
        return {'error': 'IP address is not a valid '};
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        return {'error': 'Internet Error'};
      } else {
        return {'error': e.toString()};
      }
    }
  }

  @override
  Future<int> getAsn() async {
    return int.parse(await getSeeIp('asn'));
  }

  @override
  Future<int> getAsnFor(String ip) async {
    return int.parse(await getSeeIpFor(key: 'asn', ip: ip));
  }

  @override
  Future<String> getCity() async {
    return getSeeIp('city');
  }

  @override
  Future<String> getCityFor(String ip) {
    return getSeeIpFor(key: 'city', ip: ip);
  }

  @override
  Future<String> getContinentCode() async {
    return getSeeIp('continent_code');
  }

  @override
  Future<String> getContinentCodeFor(String ip) {
    return getSeeIpFor(key: 'continent_code', ip: ip);
  }

  @override
  Future<String> getCountry() {
    return getSeeIp('country');
  }

  @override
  Future<String> getCountryCode() {
    return getSeeIp('country_code');
  }

  @override
  Future<String> getCountryCode3() {
    return getSeeIp('country_code3');
  }

  @override
  Future<String> getCountryCode3For(String ip) {
    return getSeeIpFor(key: 'country_code3', ip: ip);
  }

  @override
  Future<String> getCountryCodeFor(String ip) {
    return getSeeIpFor(key: 'country_code', ip: ip);
  }

  @override
  Future<String> getCountryFor(String ip) {
    return getSeeIpFor(key: 'country', ip: ip);
  }

  @override
  Future<String> getIp({Ip version = Ip.v4}) async {
    try {
      return jsonDecode(jsonEncode((await http.get(Uri.parse(
              'https://ip${version == Ip.v4 ? 'v4' : 'v6'}.seeip.org')))
          .body));
    } on Exception catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> getIpv4() {
    return getIp(version: Ip.v4);
  }

  @override
  Future<String> getIpv6() {
    return getIp(version: Ip.v6);
  }

  @override
  Future<double> getLatitude() async {
    return double.parse(await getSeeIp('latitude'));
  }

  @override
  Future<double> getLatitudeFor(String ip) async {
    return double.parse(await getSeeIpFor(key: 'latitude', ip: ip));
  }

  @override
  Future<double> getLongitude() async {
    return double.parse(await getSeeIp('longitude'));
  }

  @override
  Future<double> getLongitudeFor(String ip) async {
    return double.parse(await getSeeIpFor(key: 'longitude', ip: ip));
  }

  @override
  Future<int> getOffset() async {
    return int.parse(await getSeeIp('offset'));
  }

  @override
  Future<int> getOffsetFor(String ip) async {
    return int.parse(await getSeeIpFor(key: 'offset', ip: ip));
  }

  @override
  Future<String> getOrganization() {
    return getSeeIp('organization');
  }

  @override
  Future<String> getOrganizationFor(String ip) {
    return getSeeIpFor(key: 'organization', ip: ip);
  }

  @override
  Future<String> getPostalCode() {
    return getSeeIp('postal_code');
  }

  @override
  Future<String> getPostalCodeFor(String ip) {
    return getSeeIpFor(key: 'postal_code', ip: ip);
  }

  @override
  Future<String> getRegion() {
    return getSeeIp('region');
  }

  @override
  Future<String> getRegionCode() {
    return getSeeIp('region_code');
  }

  @override
  Future<String> getRegionCodeFor(String ip) {
    return getSeeIpFor(key: 'region_code', ip: ip);
  }

  @override
  Future<String> getRegionFor(String ip) {
    return getSeeIpFor(key: 'region', ip: ip);
  }

  @override
  Future<String> getSeeIp(String key) async {
    try {
      var _json = jsonDecode(
              (await http.get(Uri.parse('https://api.seeip.org/geoip/')))
                  .body)[key]
          .toString();
      if (_json == 'null') {
        return '$key not found';
      } else {
        return _json;
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> getSeeIpFor({required String key, required String ip}) async {
    try {
      var _json = jsonDecode(
              (await http.get(Uri.parse('https://api.seeip.org/geoip/$ip')))
                  .body)[key]
          .toString();
      if (_json == 'null') {
        return '$key not found';
      } else {
        return _json;
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> getTimeZone() {
    return getSeeIp('timezone');
  }

  @override
  Future<String> getTimeZoneFor(String ip) {
    return getSeeIpFor(key: 'timezone', ip: ip);
  }
}
