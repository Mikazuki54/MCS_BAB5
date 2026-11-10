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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>()
        ..getTemperature()
        ..getHumidity()
        ..getSoilMoisture();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agro Tech", style: AppStyles.whiteBoldTextStyle),
        centerTitle: true,
        backgroundColor: AppStyles.mainColor,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Text(
              AppStyles.loremIpsum,
              style: AppStyles.boldTextStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppStyles.mainColor,
                  ),
                  child: Text("Continue", style: AppStyles.whiteBoldTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
