# Usage

_To get your ip address, just use `IpAddress.getIp()`:_

```dart
import 'package:public_ip_address/public_ip_address.dart';

void main() async {
  var ip = await IpAddress().getIp();
  print(ip);
  // Sample Output : 208.XX.XX.XX
  var allIP = await IpAddress().getAllData();
  print(allIP);
  //Sample Output :
  // {ip: 202.XX.XX.XX, continentCode: AS, country: [COUNTRY NAME], 
  // countryCode: [COUNTRY CODE], countryCode3: [COUNTRY CODE 3],
  // latitude: [LAT],longitude: [LNG], timeZone: Asia/Kathmandu, offset: 20700,
  // asn: 4007,organization: [ISP ORGANIZATION NAME] region: [REGION], regionCode: [REGION CODE]}
}
```

_Don't forget to `await` it because it's a [Future function]('https://dart.dev/codelabs/async-await)
