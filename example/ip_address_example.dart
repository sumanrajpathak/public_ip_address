import 'package:public_ip_address/public_ip_address.dart';

void main() async {
  var ip = await IpAddress.getIp();
  print(ip);
  // Sample Output : 208.XX.XX.XX
  var geoIP = await IpAddress.getAllData();
  print(geoIP);
  //Sample Output :
  // {ip: 202.XX.XX.XX, continentCode: AS, country: [COUNTRY NAME],
  // countryCode: [COUNTRY CODE], countryCode3: [COUNTRY CODE 3],
  // latitude: [LAT],longitude: [LNG], timeZone: Asia/Kathmandu, offset: 20700,
  // asn: 4007,organization: [ISP ORGANIZATION NAME] region: [REGION], regionCode: [REGION CODE]}
}
