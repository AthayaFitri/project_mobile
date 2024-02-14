// ignore_for_file: avoid_print, constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../../widgets/clock_view_widget.dart';

enum Timezone {
  WIB,
  WITA,
  WIT,
  GMT,
}

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Timezone selectedTimezone = Timezone.WIB;
  late tz.Location selectedLocation;

  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();
    selectedLocation = tz.getLocation('Asia/Jakarta');
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';

    if (!timezoneString.startsWith('-')) {
      offsetSign = '+';
    }

    return Scaffold(
      backgroundColor: CustomColors.myColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Clock',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 64,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: DigitalClockWidget(
                location: selectedLocation,
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.center,
                child: ClockView(
                  size: MediaQuery.of(context).size.height / 4,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Timezone',
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w500,
                      color: CustomColors.primaryTextColor,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.language,
                        color: CustomColors.primaryTextColor,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'UTC$offsetSign$timezoneString',
                        style: const TextStyle(
                          fontFamily: 'avenir',
                          color: CustomColors.primaryTextColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: CustomColors.myColor,
                        ),
                        child: DropdownButton<Timezone>(
                          value: selectedTimezone,
                          onChanged: (Timezone? newValue) {
                            switch (newValue) {
                              case Timezone.WIB:
                                selectedLocation =
                                    tz.getLocation('Asia/Jakarta');
                                break;
                              case Timezone.WITA:
                                selectedLocation =
                                    tz.getLocation('Asia/Makassar');
                                break;
                              case Timezone.WIT:
                                selectedLocation =
                                    tz.getLocation('Asia/Jayapura');
                                break;
                              case Timezone.GMT:
                                selectedLocation =
                                    tz.getLocation('Europe/London');
                                break;
                              default:
                                selectedLocation =
                                    tz.getLocation('Asia/Jakarta');
                            }
                            selectedTimezone = newValue!;
                            setState(() {});
                          },
                          iconEnabledColor: Colors.white,
                          items: Timezone.values.map((Timezone timezone) {
                            return DropdownMenuItem<Timezone>(
                              value: timezone,
                              child: Text(
                                timezone.toString().split('.')[1],
                                style: const TextStyle(
                                  fontFamily: 'avenir',
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  final tz.Location location;

  const DigitalClockWidget({super.key, required this.location});

  @override
  State<DigitalClockWidget> createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  late tz.Location location;
  late tz.TZDateTime _currentTime;

  @override
  void initState() {
    super.initState();
    location = widget.location;
    _updateTime();
    _startTimer();
  }

  void _updateTime() {
    _currentTime = tz.TZDateTime.now(location);
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _updateTime();
      });
    });
  }

  @override
  void didUpdateWidget(DigitalClockWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.location != oldWidget.location) {
      location = widget.location;
      _updateTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HH:mm').format(_currentTime);
    String formattedDate = DateFormat('EEE d MMM').format(_currentTime);
    print('=====>digital clock updated');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          formattedTime,
          style: const TextStyle(
            fontFamily: 'avenir',
            color: CustomColors.primaryTextColor,
            fontSize: 64,
          ),
        ),
        Text(
          formattedDate,
          style: const TextStyle(
            fontFamily: 'avenir',
            fontWeight: FontWeight.w300,
            color: CustomColors.primaryTextColor,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
