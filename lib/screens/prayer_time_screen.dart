import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../models/prayer_time.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  PrayerTime time = PrayerTime();
  bool isLoading = false;

  Future<void> getPrayerTime(String city) async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await http
        .get(Uri.parse("https://dailyprayer.abdulrcs.repl.co/api/$city"));

    setState(() {
      time = PrayerTime.fromJson(jsonDecode(response.body));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 50,
          ),
          TextField(
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Enter your city",
              labelText: "City Name",
              labelStyle: Theme.of(context).textTheme.bodySmall,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)),
            ),
            onSubmitted: (value) {
              getPrayerTime(value);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _bodyWidget(),
          ),
        ]),
      ),
    );
  }

  Widget _timeCard(String name, String time) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black.withOpacity(0.4)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const Icon(
              Icons.timer_outlined,
              color: Colors.white,
              size: 25,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ]),
    );
  }

  Widget _bodyWidget() {
    if (isLoading) {
      return _loadingWidget();
    } else if (time.today == null) {
      return _emptyWidget();
    } else {
      return _prayerTimeWidget();
    }
  }

  Widget _loadingWidget() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Lottie.asset("assets/animations/loading.json", animate: true),
    ));
  }

  Widget _emptyWidget() {
    return Center(
      child: Text(
        "Enter your city to fetch the prayer time",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _prayerTimeWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${time.city}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "${time.date}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 30,
          ),
          _timeCard("Fajr", "${time.today?.fajr}"),
          _timeCard("Sunrise", "${time.today?.sunrise}"),
          _timeCard("Dhuhr", "${time.today?.dhuhr}"),
          _timeCard("Asr", "${time.today?.asr}"),
          _timeCard("Maghrib", "${time.today?.maghrib}"),
          _timeCard("Ishak", "${time.today?.ishaA}"),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
