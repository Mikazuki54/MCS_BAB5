import 'package:bab5/providers/app_provider.dart';
import 'package:bab5/widget/app_styles.dart';
import 'package:bab5/widget/custom_read_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Agro Tech", style: AppStyles.whiteRoboto14Bold),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppStyles.mainColor,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                //field untuk temperatur
                CustomReadField(
                  hasil: appProvider.field1model!.field1, 
                  warnaBorder: AppStyles.mainColor, 
                  gambar: AppStyles.gambarThermometer,
                ),

                const SizedBox(height: 20),

                CustomReadField(
                  hasil: appProvider.field2model!.field2, 
                  warnaBorder: AppStyles.mainColor, 
                  gambar: AppStyles.gambarSensorHumidity,
                ),

                const SizedBox(height: 20),

                CustomReadField(
                  hasil: appProvider.field3model!.field3, 
                  warnaBorder: AppStyles.mainColor, 
                  gambar: AppStyles.gambarSoilAnalysis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}