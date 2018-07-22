import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('clicking on the plus sign shows Add todo screen', () async {
    await driver.tap(find.text('+'));
    await driver.waitFor(find.text('Add todo'));
  });
}