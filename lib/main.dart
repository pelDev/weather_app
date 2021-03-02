import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Lagos&units=imperial&appid=f069ae82032b60a3f038a3b27aa4f6f0");
    var result = json.decode(response.body);
    setState(() {
      this.temp = result["main"]["temp"];
      this.description = result["weather"][0]["description"];
      this.currently = result["weather"][0]["main"];
      this.humidity = result["main"]["humidity"];
      this.windSpeed = result["wind"]["speed"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  "Currently in Lagos",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Temperature",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.grey[100],
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      FaIcon(
                        FontAwesomeIcons.thermometerHalf,
                        size: 50.0,
                      ),
                      Container(
                        width: 1.0,
                        height: double.infinity,
                        color: Colors.black,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: temp != null
                                  ? temp.toString() + "\u00B0"
                                  : "Loading...",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            TextSpan(
                              text: temp != null ? "c" : "",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Humidity",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.grey[100],
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      FaIcon(
                        FontAwesomeIcons.sun,
                        size: 50.0,
                      ),
                      Container(
                        width: 1.0,
                        height: double.infinity,
                        color: Colors.black,
                      ),
                      Text(
                        humidity != null ? humidity.toString() : "Loading...",
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Wind Speed",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.grey[100],
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      FaIcon(
                        FontAwesomeIcons.wind,
                        size: 50.0,
                      ),
                      Container(
                        width: 1.0,
                        height: double.infinity,
                        color: Colors.black,
                      ),
                      Text(
                        windSpeed != null ? windSpeed.toString() : "Loading...",
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
