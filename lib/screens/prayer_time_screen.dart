import 'package:flutter/material.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/bg.png"))),
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "Karachi",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Wed,12 Jul 2023",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Spacer(),
          _timeCard("Fajr", "05:00"),
          _timeCard("Sunrise", "07:00"),
          _timeCard("Dhuhr", "12:00"),
          _timeCard("Asr", "05:00"),
          _timeCard("Maghrib", "07:00"),
          _timeCard("Ishak", "09:00"),
          const SizedBox(
            height: 20,
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
}
