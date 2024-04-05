import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:public_ip_address/src/ip_repository.dart';

enum Ip { v4, v6 }

class IpAddress extends IpRepository {
  /// Gets all data for the current device's public IP Address.
  ///
  /// Returns a [Map<String, dynamic>] with all data from the API or an
  /// error [Map] if there was an error.
  ///
  /// The [version] parameter specifies the IP version to be used,
  /// with `Ip.v4` being the default and `Ip.v6` being the IPv6 version.
  ///
  /// Throws a [SocketException] if there is no internet connection.
  @override
  Future<Map<String, dynamic>> getAllData({Ip version = Ip.v4}) async {
    try {
      final Map<String, dynamic> _json = jsonDecode((await http.get(
        Uri.parse(
          'https://ip${version == Ip.v4 ? 'v4' : 'v6'}.seeip.org/geoip',
        ),
      ))
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

  /// Fetches data for the given [ip] address.
  ///
  /// Returns a [Map] containing information about the given [ip] address.
  /// The [Map] contains the following keys:
  ///
  /// * `continentCode`
  /// * `country`
  /// * `countryCode`
  /// * `countryCode3`
  /// * `latitude`
  /// * `longitude`
  /// * `timeZone`
  /// * `offset`
  /// * `asn`
  /// * `organization` (optional)
  /// * `region` (optional)
  /// * `regionCode` (optional)
  /// * `city` (optional)
  /// * `postal_code` (optional)
  ///
  /// Throws a [SocketException] if there is no internet connection.
  /// If the given [ip] is not a valid IP address,
  /// it will throw a [FormatException]
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
  // Retrieves the ASN by parsing the integer value obtained from the 'asn' key of the 'seeIp' response.
  Future<int> getAsn() async {
    return int.parse(await getSeeIp('asn'));
  }

  @override
  // Asynchronously retrieves the Autonomous System Number (ASN) for the given IP address.
  // 
  // Parameters:
  //   ip (String): The IP address for which to retrieve the ASN.
  //
  // Returns:
  //   Future<int>: A Future that resolves to the ASN as an integer.
  Future<int> getAsnFor(String ip) async {
    return int.parse(await getSeeIpFor(key: 'asn', ip: ip));
  }

  @override
  // A function that asynchronously retrieves the city from the getSeeIp method and returns it as a String.
  Future<String> getCity() async {
    return getSeeIp('city');
  }

  @override
  // A function that retrieves the city information for a given IP address.
  // 
  // Parameters:
  //   ip - A String representing the IP address for which the city information is requested.
  // 
  // Returns:
  //   A Future<String> containing the city information associated with the provided IP address.
  Future<String> getCityFor(String ip) {
    return getSeeIpFor(key: 'city', ip: ip);
  }

  @override
  // Retrieves the continent code using the getSeeIp function and returns it as a String.
  Future<String> getContinentCode() async {
    return getSeeIp('continent_code');
  }

  @override
  // A function that retrieves the continent code for a given IP address.
  Future<String> getContinentCodeFor(String ip) {
    return getSeeIpFor(key: 'continent_code', ip: ip);
  }

  @override
  // Retrieves the country information using the getSeeIp function and returns it as a Future<String>.
  Future<String> getCountry() {
    return getSeeIp('country');
  }

  @override
  // Retrieves the country code using the getSeeIp function and returns it as a string.
  Future<String> getCountryCode() {
    return getSeeIp('country_code');
  }

  @override
  // Retrieves the country code in ISO 3166-1 alpha-3 format.
  Future<String> getCountryCode3() {
    return getSeeIp('country_code3');
  }

  @override
  Future<String> getCountryCode3For(String ip) {
    return getSeeIpFor(key: 'country_code3', ip: ip);
  }

  @override
  // Get the country code for the given IP address.
  Future<String> getCountryCodeFor(String ip) {
    return getSeeIpFor(key: 'country_code', ip: ip);
  }

  @override
  // Retrieves the country for the given IP address.
  Future<String> getCountryFor(String ip) {
    return getSeeIpFor(key: 'country', ip: ip);
  }

  @override
  // A function that retrieves the IP address from 'https://ip{version}.seeip.org' using HTTP GET request.
  // It takes an optional parameter 'version' of type 'Ip' which defaults to 'Ip.v4'.
  // Returns a Future<String> containing the retrieved IP address or an error message.
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
  // Retrieves the IPv4 address using the getIp function and returns it as a string.
  Future<String> getIpv4() {
    return getIp(version: Ip.v4);
  }

  @override
  // A function that returns an IPv6 address by calling the getIp function with the version parameter set to Ip.v6.
  Future<String> getIpv6() {
    return getIp(version: Ip.v6);
  }

  @override
  // A function that asynchronously retrieves latitude information and returns it as a double.
  Future<double> getLatitude() async {
    return double.parse(await getSeeIp('latitude'));
  }

  @override
  Future<double> getLatitudeFor(String ip) async {
    return double.parse(await getSeeIpFor(key: 'latitude', ip: ip));
  }

  @override
  // Retrieves the longitude by parsing the result of the 'getSeeIp' function as a double value.
  Future<double> getLongitude() async {
    return double.parse(await getSeeIp('longitude'));
  }

  @override
  // Retrieves the longitude for the given IP address by calling getSeeIpFor function asynchronously.
  Future<double> getLongitudeFor(String ip) async {
    return double.parse(await getSeeIpFor(key: 'longitude', ip: ip));
  }

  @override
  // A function that returns the offset as an integer after parsing the result of the 'getSeeIp' function.
  Future<int> getOffset() async {
    return int.parse(await getSeeIp('offset'));
  }

  @override
  // Get the offset for a given IP by parsing the result of fetching the 'offset' information for that IP.
  Future<int> getOffsetFor(String ip) async {
    return int.parse(await getSeeIpFor(key: 'offset', ip: ip));
  }

  @override
  // Retrieves the organization information using the getSeeIp function and returns it as a string.
  Future<String> getOrganization() {
    return getSeeIp('organization');
  }

  @override
  // Retrieves the organization for the given IP address.
  Future<String> getOrganizationFor(String ip) {
    return getSeeIpFor(key: 'organization', ip: ip);
  }

  @override
  // Get the postal code by calling the getSeeIp function with the 'postal_code' parameter.
  Future<String> getPostalCode() {
    return getSeeIp('postal_code');
  }

  @override
  // Retrieves the postal code for the given IP address.
  Future<String> getPostalCodeFor(String ip) {
    return getSeeIpFor(key: 'postal_code', ip: ip);
  }

  @override
  Future<String> getRegion() {
    return getSeeIp('region');
  }

  @override
  // Retrieves the region code using the getSeeIp function and returns it as a String.
  Future<String> getRegionCode() {
    return getSeeIp('region_code');
  }

  @override
  // A function that retrieves the region code for a given IP address.
  Future<String> getRegionCodeFor(String ip) {
    return getSeeIpFor(key: 'region_code', ip: ip);
  }

  @override
  // Get the region for the given IP address.
  Future<String> getRegionFor(String ip) {
    return getSeeIpFor(key: 'region', ip: ip);
  }

  @override
  // A function that makes a GET request to 'https://api.seeip.org/geoip/' to retrieve JSON data
  // and returns a specific value based on the provided key. If the key is not found or an exception occurs, appropriate messages are returned.
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
  // A function that retrieves specific information for a given IP address from the SeeIP API.
  // Takes in 'key' as the information to retrieve and 'ip' as the IP address to query.
  // Returns a Future<String> with the requested information or an error message.
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
  // Get the time zone using the getSeeIp method and return it as a string.
  Future<String> getTimeZone() {
    return getSeeIp('timezone');
  }

  @override
  // Retrieves the time zone for the given IP address.
  Future<String> getTimeZoneFor(String ip) {
    return getSeeIpFor(key: 'timezone', ip: ip);
  }
}
