import 'package:bab5/providers/app_provider.dart';
import 'package:bab5/screens/home_page.dart';
import 'package:bab5/widget/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Provider.of<AppProvider>(context, listen: false).getTemperature();
    Provider.of<AppProvider>(context, listen: false).getHumidity();
    Provider.of<AppProvider>(context, listen: false).getSoilMoisture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Agro Tech",
              style: AppStyles.whiteRoboto14Bold,
            ),
            centerTitle: true,
            backgroundColor: AppStyles.mainColor,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                    AppStyles.loremIpsum,
                    style: AppStyles.roboto14Bold,
                    textAlign: TextAlign.justify,
                  ),
                ),
                
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: AppStyles.mainColor,
                        ),
                        child: Text(
                          "Continue",
                          style: AppStyles.whiteRoboto14Bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}