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

_Don't forget to `await` it because it's a [Future function]('https://dart.dev/codelabs/async-await)._