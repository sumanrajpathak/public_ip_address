import 'dart:convert';

import 'package:http/http.dart' as http;

enum Ip { v4, v6 }

/// Example:
/// ```dart
/// void main() async {
///   String ip = await IpAddress.getIp();
///   print(ip);
///  // Output : 208.67.222.222
/// }
/// ```
class IpAddress {
  static Future<String> _getSeeIp(String key) async {
    try {
      var _json = jsonDecode(
              (await http.get(Uri.parse('https://ip.seeip.org/geoip/')))
                  .body)[key]
          .toString();
      if (_json == 'null') {
        return '$key not found';
      } else {
        return _json;
      }
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }
  }

  /// Return all data for  of the visitor ip address . The default Ip version is 4 .
  ///
  /// If the request is successful, the output will be a map containing :
  /// - ip
  /// - continentCode
  /// - country
  /// - countryCode
  /// - countryCode3
  /// - latitude
  /// - longitude
  /// - timeZone
  /// - offset
  /// - asn
  /// - organization
  ///
  /// You can change also change the IP version to 6
  ///  Use 4 for `IPV4` or 6 for `IPV6`

  static Future<Map<String, dynamic>> getAllData({Ip version = Ip.v4}) async {
    try {
      Map<String, dynamic> _json = jsonDecode((await http.get(Uri.parse(
              'https://ip${(version.toString())[4]}.seeip.org/geoip')))
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
      print(e);
      if (e.toString().contains('SocketException')) {
        return {'error': 'Internet Error'};
      } else {
        return {'error': e.toString()};
      }
    }
  }

  /// Return the visitor Ip address value. The default Ip version is 4 .
  ///
  /// You can change also change the IP version to 6
  ///
  ///  Use 4 for `IPV4` or 6 for `IPV6`
  static Future<String> getIp({Ip version = Ip.v4}) async {
    try {
      return jsonDecode(jsonEncode((await http.get(
              Uri.parse('https://ip${(version.toString())[4]}.seeip.org/')))
          .body));
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }
  }

  /// Return the `Ipv4` (Ip version 4) address value of the visitor ip .
  ///
  static Future<String> getIpv4() async {
    return getIp(version: Ip.v4);
  }

  /// Return the `Ipv6` (Ip version 6) address value of the visitor  .
  ///
  static Future<String> getIpv6() async {
    return getIp(version: Ip.v4);
  }

  /// Return the Continent Code of the visitor ip .
  static Future<String> getContinentCode() async {
    return _getSeeIp('continent_code');
  }

  /// Return the Name of the country of the visitor ip .
  static Future<String> getCountry() async {
    return _getSeeIp('country');
  }

  /// Return the Two-letter ISO 3166-1 alpha-2 country code .
  static Future<String> getCountryCode() async {
    return _getSeeIp('country_code');
  }

  /// Return the Three-letter ISO 3166-1 alpha-3 country code
  static Future<String> getCountryCode3() async {
    return _getSeeIp('country_code3');
  }

  /// Return the Latitude of the visitor ip .
  static Future<double> getLatitude() async {
    return double.parse('latitude');
  }

  /// Return the Longitude of the visitor ip .
  static Future<double> getLongitude() async {
    return double.parse('longitude');
  }

  /// Return the TimeZone of the visitor ip .
  static Future<String> getTimeZone() async {
    return _getSeeIp('timezone');
  }

  /// Return the UTC time offset of the visitor ip .
  static Future<int> getOffset() async {
    return int.parse('offset');
  }

  /// Return the Asn of the visitor ip .
  static Future<int> getAsn() async {
    return int.parse('asn');
  }

  /// Return the organization or Internet service provider (ASN + ISP name) of the visitor ip .
  /// Usage :
  ///  ```dart
  /// int organization = await IpAddress.getOrganization();
  /// // Sample Output : "AS36692 OpenDNS, LLC"
  /// ```
  static Future<String> getOrganization() async {
    return _getSeeIp('organization');
  }

  /// If there is a Region associated with your ip address, it will the name
  static Future<String> getRegion() async {
    return _getSeeIp('region');
  }

  /// If there is a Region Code associated with your ip address, it will be returned .
  static Future<String> getRegionCode() async {
    return _getSeeIp('region_code');
  }

  /// If there is a City associated with your ip address, it will the name .
  static Future<String> getCity() async {
    return _getSeeIp('city');
  }

  /// If there is a Postal code/Zip code associated with your ip address, it will be returned .
  static Future<String> getPostalCode() async {
    return _getSeeIp('postal_code');
  }

//------------------------------------------------------------------------------     For Ip
  /// Return all data for a specific ip address
  /// If the request is successful, the output will be a map containing :
  /// - continentCode
  /// - country
  /// - countryCode
  /// - countryCode3
  /// - latitude
  /// - longitude
  /// - timeZone
  /// - offset
  /// - asn
  /// - organization
  ///
  static Future<Map<String, dynamic>> getAllDataFor(String ip) async {
    try {
      Map _json = jsonDecode(
          (await http.get(Uri.parse('https://ip.seeip.org/geoip/$ip'))).body);
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
      print(e);
      if (e.toString().contains('SocketException')) {
        return {'error': 'Internet Error'};
      } else {
        return {'error': e.toString()};
      }
    }
  }

  //----------seeIpFor
  static Future<String> _getSeeIpFor(String key, {required String ip}) async {
    try {
      var _json = jsonDecode(
              (await http.get(Uri.parse('https://ip.seeip.org/geoip/$ip')))
                  .body)[key]
          .toString();
      if (_json == 'null') {
        return '$key not found';
      } else {
        return _json;
      }
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }
  }

  /// Return the continent code for a specific ip address .
  static Future<String> getContinentCodeFor(String ip) async {
    return _getSeeIpFor('continent_code', ip: ip);
  }

  /// Return the country for a specific ip address .
  static Future<String> getCountryFor(String ip) async {
    return _getSeeIpFor('country', ip: ip);
  }

  /// Return the country code for a specific ip address .
  static Future<String> getCountryCodeFor(String ip) async {
    return _getSeeIpFor('country_code', ip: ip);
  }

  /// Return the country code for a specific ip address .
  static Future<String> getCountryCode3For(String ip) async {
    return _getSeeIpFor('country_code3', ip: ip);
  }

  /// Return the latitude for a specific ip address .
  static Future<double> getLatitudeFor(String ip) async {
    return double.parse(await _getSeeIpFor('latitude', ip: ip));
  }

  /// Return the longitude for a specific ip address .
  static Future<double> getLongitudeFor(String ip) async {
    return double.parse(await _getSeeIpFor('longitude', ip: ip));
  }

  /// Return the timeZone for a specific ip address .
  static Future<String> getTimeZoneFor(String ip) async {
    return _getSeeIpFor('timezone', ip: ip);
  }

  /// Return the offset for a specific ip address .
  static Future<int> getOffsetFor(String ip) async {
    return int.parse(await _getSeeIpFor('offset', ip: ip));
  }

  /// Return the asn for a specific ip address .
  static Future<int> getAsnFor(String ip) async {
    return int.parse(await _getSeeIpFor('asn', ip: ip));
  }

  /// Return the internet organization for a specific ip address .
  static Future<String> getOrganizationFor(String ip) async {
    return _getSeeIpFor('organization', ip: ip);
  }

  /// If there is a Region associated with your ip address, it will the name .
  static Future<String> getRegionFor(String ip) async {
    return _getSeeIpFor('region', ip: ip);
  }

  /// If there is a Region Code associated with your ip address, it will be returned
  static Future<String> getRegionCodeFor(String ip) async {
    return _getSeeIpFor('region_code', ip: ip);
  }

  /// If there is a City associated with your ip address, it will the name .
  static Future<String> getCityFor(String ip) async {
    return _getSeeIpFor('city', ip: ip);
  }

  /// If there is a Postal code/Zip code associated with your ip address, it will be returned
  static Future<String> getPostalCodeFor(String ip) async {
    return _getSeeIpFor('postal_code', ip: ip);
  }
}
