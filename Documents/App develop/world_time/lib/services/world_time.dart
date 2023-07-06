// ignore_for_file: avoid_print

import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ""; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  late bool isDaytime; // true or flase if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      // } on HandshakeException catch (e) {
      //   Fluttertoast.showToast(
      //     msg: 'Please try again!',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //   );
      //   print('${e.message}');
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
