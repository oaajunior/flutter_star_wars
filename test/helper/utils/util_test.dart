import 'package:app_star_wars/utils/util.dart';
import 'package:test/test.dart';

main() {
  group('Util', () {
    test('Convert a number between 1 and 7 to roman numerals, testing number 1',
        () {
      var number = 1;
      expect(Util.convertToRoman(number), 'I');
    });

    test('Convert a number between 1 and 7 to roman numerals, testing number 7',
        () {
      var number = 7;
      expect(Util.convertToRoman(number), 'VII');
    });

    test(
        'Convert a number between 1 and 7 to roman numerals, testing null value',
        () {
      var nullNumber;
      expect(Util.convertToRoman(nullNumber), isEmpty);
    });
    test('Put a jpg extension in an image id', () {
      var id = "1";
      expect(Util.coverImageID(id: id), "$id.jpg");
    });

    test('Put a jpg extension in an image id, testing an empty value', () {
      var id = "";
      expect(Util.coverImageID(id: id), "");
    });
    test('Put a jpg extension in an image id, testing a null value', () {
      var nullString;
      expect(Util.coverImageID(id: nullString), "");
    });

    test('Forming a url image network, testing normal value', () {
      var type = 'films';
      var id = '1';
      expect(Util.networkImageID(type: type, id: id),
          "https://raw.githubusercontent.com/oaajunior/flutter_project_images/master/images/films/1.jpg");
    });

    test('Forming a url image network, testing null type', () {
      var type;
      var id = '1';
      expect(Util.networkImageID(type: type, id: id), isEmpty);
    });

    test('Forming a url image network, testing null id', () {
      var type = 'films';
      var id;
      expect(Util.networkImageID(type: type, id: id), isEmpty);
    });

    test('Forming a url image network, testing null type and null id', () {
      var type;
      var id;
      expect(Util.networkImageID(type: type, id: id), isEmpty);
    });

    test('Transform the date format, testing a normal date', () {
      var date = "1977-05-25";
      expect(Util.treatDate(date), "05-25-1977");
    });

    test('Transform the date format, testing empty date', () {
      var date = '';
      expect(Util.treatDate(date), isEmpty);
    });

    test('Transform the date format, testing null date', () {
      var date;
      expect(Util.treatDate(date), isEmpty);
    });

    test('Extract id from correct url', () {
      var url = "http://swapi.dev/api/films/1/";
      expect(Util.extractID(url), "1");
    });
    test('Extract id from incorrect url', () {
      var url = "incorrect url";
      expect(Util.extractID(url), isNull);
    });
  });
}
