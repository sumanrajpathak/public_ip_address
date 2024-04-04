import 'package:public_ip_address/public_ip_address.dart';

abstract class IpRepository {
  Future<String> getSeeIp(String key);
  Future<Map<String, dynamic>> getAllData({Ip version = Ip.v4});
  Future<String> getIp({Ip version = Ip.v4});
  Future<String> getIpv4();
  Future<String> getIpv6();
  Future<String> getContinentCode();
  Future<String> getCountry();
  Future<String> getCountryCode();
  Future<String> getCountryCode3();
  Future<double> getLatitude();
  Future<double> getLongitude();
  Future<String> getTimeZone();
  Future<int> getOffset();
  Future<int> getAsn();
  Future<String> getOrganization();
  Future<String> getRegion();
  Future<String> getRegionCode();
  Future<String> getCity();
  Future<String> getPostalCode();

  Future<Map<String, dynamic>> getAllDataFor(String ip);
  Future<String> getSeeIpFor({required String key, required String ip});
  Future<String> getContinentCodeFor(String ip);
  Future<String> getCountryFor(String ip);
  Future<String> getCountryCodeFor(String ip);
  Future<String> getCountryCode3For(String ip);
  Future<double> getLatitudeFor(String ip);
  Future<double> getLongitudeFor(String ip);
  Future<String> getTimeZoneFor(String ip);
  Future<int> getOffsetFor(String ip);
  Future<int> getAsnFor(String ip);
  Future<String> getOrganizationFor(String ip);
  Future<String> getRegionFor(String ip);
  Future<String> getRegionCodeFor(String ip);
  Future<String> getCityFor(String ip);
  Future<String> getPostalCodeFor(String ip);
}
