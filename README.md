[![pub package](https://img.shields.io/pub/v/http.svg)](https://pub.dev/packages/http)
[![package publisher](https://img.shields.io/pub/publisher/http.svg)](https://pub.dev/packages/http/publisher)
# Public IP Address


This package allows you to obtain your public IP address and many other information about it

## Features

You can get the public IP address of the user or many other information about a specific IP address, such as :

- Name of the country
- Time Zone
- Latitude
- Longitude
- Name of the City
- Name of the Region
- Region Code
- Postal Code
- The organization or Internet service provider
- Continent Code
- Two-letter ISO 3166-1 alpha-2 country code
- Three-letter ISO 3166-1 alpha-3 country code
- The UTC time offset
- The Asn

## Getting started

Add this to your dependencies :

```yaml
dependencies:

  public_ip_address: ^1.0.0
```
And import :

```dart
import 'package:public_ip_address/public_ip_address.dart';
```

## Usage

_To get your ip address, just use `IpAddress.getIp()`:_

```dart
import 'package:public_ip_address/public_ip_address.dart';

void main() async {
  var ip = await IpAddress.getIp();
  print(ip);
  // Sample Output : 208.67.222.222
}
```

_Don't forget to `await` it because it's a [Future function](https://dart.dev/codelabs/async-await)._

## Others functionalities

- To get all data about the user's IP address , use `getAllData()` :

```dart
Map allData = await IpAddress.getAllData();
```

_For a specific ip , use `getAllDataFor('specific_ip')` method instead ._

- To get only the user's IP address, use :
  `IpAddress.getIp()`:

```dart
String ip = await IpAddress.getIp();
// Sample Output : "208.67.222.222"
```

- To get the `Ipv4` (Ip version 4) address value of the user's IP , use :
  `IpAddress.getIpv4()`:

```dart
String ipv4 = await IpAddress.getIpv4();
// Sample Output : "208.67.222.222"
```

- To get the `Ipv6` (Ip version 6) address value of the user's IP , use :
  `IpAddress.getIpv6()`:

```dart
String ipv6 = await IpAddress.getIpv6();
// Sample Output : "2a05:dfc7:5::53"
```

- To get the Continent Code of the user's IP , use :
  `IpAddress.getContinentCode()`:

```dart
String continentCode = await IpAddress.getContinentCode();
// Sample Output : "NA"
```

_For a specific ip , use `getContinentCodeFor('specific_ip')` method instead ._

- To get the Country of the user's IP , use :
  `IpAddress.getCountry()`:

```dart
String country = await IpAddress.getCountry();
// Sample Output : "United States"
```

_For a specific ip , use `getCountryFor('specific_ip')` method instead ._

- To get the Two-letter ISO 3166-1 alpha-2 country code of the user's IP , use :
  `IpAddress.getCountryCode()`:

```dart
String countryCode = await IpAddress.getCountryCode();
// Sample Output : "US"
```

_For a specific ip , use `getCountryCodeFor('specific_ip')` method instead ._

- To get the Three-letter ISO 3166-1 alpha-3 country code of the user's IP , use :
  `IpAddress.getCountryCode3()`:

```dart
String countryCode3 = await IpAddress.getCountryCode3();
// Sample Output : "USA"
```

_For a specific ip , use `getCountryCode3For('specific_ip')` method instead ._

- To get the Latitude of the user's IP , use :
  `IpAddress.getLatitude()`:

```dart
double latitude = await IpAddress.getLatitude();
// Sample Output : 37.7697
```

_For a specific ip , use `getLatitudeFor('specific_ip')` method instead ._

- To get the Longitude of the user's IP , use :
  `IpAddress.getLongitude()`:

```dart
double longitude = await IpAddress.getLongitude();
// Sample Output : -122.3933
```

_For a specific ip , use `getLongitudeFor('specific_ip')` method instead ._

- To get the TimeZone of the user's IP , use :
  `IpAddress.getTimeZone()`:

```dart
String timeZone = await IpAddress.getTimeZone();
// Sample Output : "America\/Los_Angeles"
```

_For a specific ip , use `getTimeZoneFor('specific_ip')` method instead ._

- To get the UTC time offset of the user's IP , use :
  `IpAddress.getOffset()`:

```dart
int offset = await IpAddress.getOffset();
// Sample Output : -7
```

_For a specific ip , use `getOffsetFor('specific_ip')` method instead ._

- To get the organization or Internet service provider (ASN + ISP name) of the user's IP , use :
  `IpAddress.getOrganization()`:

```dart
int organization = await IpAddress.getOrganization();
// Sample Output : "AS36692 OpenDNS, LLC"
```

_For a specific ip , use `getOrganizationFor('specific_ip')` method instead ._

- To get the Name of the Region of the user's IP , use :
  `IpAddress.getRegion()`:

```dart
String region = await IpAddress.getRegion();
// Sample Output : "New York"
```

_For a specific ip , use `getRegionFor('specific_ip')` method instead ._

- To get the Region Code of the user's IP , use :
  `IpAddress.getRegionCode()`:

```dart
String regionCode = await IpAddress.getRegionCode();
// Sample Output : "NY"
```

_For a specific ip , use `getRegionCodeFor('specific_ip')` method instead ._

- To get the Name of the city of the user's IP , use :
  `IpAddress.getCity()`:

```dart
String city = await IpAddress.getcity();
// Sample Output : "Brooklyn"
```

_For a specific ip , use `getCityFor('specific_ip')` method instead ._

- To get the Postal code/Zip code of the user's IP , use :
  `IpAddress.getPostalCode()`:

```dart
String postalCode = await IpAddress.getPostalCode();
// Sample Output : "11213"
```

_For a specific ip , use `getPostalCodeFor('specific_ip')` method instead ._

## Additional information

Some countries do not have region and other information. For example, for some IP addresses outside the United States and Canada, information such as `region`, `regionCode`, `city` and `postalCode` may not be found.
