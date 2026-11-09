# Agro Tech - Monitoring Pertanian IoT

Aplikasi Flutter untuk memantau parameter lingkungan pertanian (suhu, kelembaban tanah, kelembaban udara) melalui API ThingSpeak.

---

## File & Penjelasan Detail

### 1. `field_model.dart` (lib/models/)

**Kode Lengkap**:
```dart
import 'dart:convert';

Field1Model field1ModelFromJson(String str) => Field1Model.fromJson(json.decode(str));

String field1ModelToJson(Field1Model data) => json.encode(data.toJson());

class Field1Model {
    final DateTime createdAt;
    final int entryId;
    final String field1;

    Field1Model({
        required this.createdAt,
        required this.entryId,
        required this.field1,
    });

    factory Field1Model.fromJson(Map<String, dynamic> json) => Field1Model(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field1: json["field1"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field1": field1,
    };
}

Field2Model field2ModelFromJson(String str) => Field2Model.fromJson(json.decode(str));

String field2ModelToJson(Field2Model data) => json.encode(data.toJson());

class Field2Model {
    final DateTime createdAt;
    final int entryId;
    final String field2;

    Field2Model({
        required this.createdAt,
        required this.entryId,
        required this.field2,
    });

    factory Field2Model.fromJson(Map<String, dynamic> json) => Field2Model(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field2: json["field2"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field2": field2,
    };
}

Field3Model field3ModelFromJson(String str) => Field3Model.fromJson(json.decode(str));

String field3ModelToJson(Field3Model data) => json.encode(data.toJson());

class Field3Model {
    final DateTime createdAt;
    final int entryId;
    final String field3;

    Field3Model({
        required this.createdAt,
        required this.entryId,
        required this.field3,
    });

    factory Field3Model.fromJson(Map<String, dynamic> json) => Field3Model(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field3: json["field3"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field3": field3,
    };
}
```

**Fungsi**: Model data untuk parsing JSON response dari API ThingSpeak.

**Isi**:
- `Field1Model`: Model untuk data suhu (field ke-1). Memiliki properti `createdAt`, `entryId`, `field1`.
- `Field2Model`: Model untuk data kelembaban udara (field ke-2). Memiliki properti `createdAt`, `entryId`, `field2`.
- `Field3Model`: Model untuk data kelembaban tanah (field ke-3). Memiliki properti `createdAt`, `entryId`, `field3`.

**Method**:
- `xxxModelFromJson(String)`: Helper function untuk convert JSON string ke model.
- `xxxModelToJson(Model)`: Helper function untuk convert model ke JSON string.
- `fromJson(Map)`: Factory constructor dari map.
- `toJson()`: Method untuk serialize object ke map.

---

### 2. `api_service.dart` (lib/services/)

**Kode Lengkap**:
```dart
import 'package:bab5/models/field_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio();

  final String readKey = "GJALAA6FCFQWBJ6M";

  String fieldUrl1 = "https://api.thingspeak.com/channels/3550228/fields/1/last.json?api_key=";
  String fieldUrl2 = "https://api.thingspeak.com/channels/3550228/fields/2/last.json?api_key="; 
  String fieldUrl3 = "https://api.thingspeak.com/channels/3550228/fields/3/last.json?api_key="; 

  Future<Field1Model> getField1() async {
    try {
      final response = await dio.get("$fieldUrl1$readKey");
      return Field1Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Field2Model> getField2() async {
    try {
      final response = await dio.get("$fieldUrl2$readKey");
      return Field2Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Field3Model> getField3() async {
    try {
      final response = await dio.get("$fieldUrl3$readKey");
      return Field3Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
```

**Fungsi**: Service untuk komunikasi dengan API ThingSpeak.

**Isi**:
- `readKey`: API key untuk akses read API (GJALAA6FCFQWBJ6M).
- `fieldUrl1/2/3`: URL endpoint untuk masing-masing field (channel 3550228).

**Method**:
- `getField1()`: Ambil data suhu terakhir dari field ke-1.
- `getField2()`: Ambil data kelembaban udara terakhir dari field ke-2.
- `getField3()`: Ambil data kelembaban tanah terakhir dari field ke-3.

**Dependency**: Menggunakan `Dio` HTTP client.

---

### 3. `app_provider.dart` (lib/providers/)

**Kode Lengkap**:
```dart
import 'package:bab5/models/field_model.dart';
import 'package:bab5/services/api_service.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  Field1Model? field1model;
  Field2Model? field2model;
  Field3Model? field3model;

  Future getTemperature() async {
    notifyListeners();
    return field1model = await ApiService().getField1();
  }

  Future getHumidity() async {
    notifyListeners();
    return field2model = await ApiService().getField2();
  }

  Future getSoilMoisture() async {
    notifyListeners();
    return field3model = await ApiService().getField3();
  }
}
```

**Fungsi**: State management menggunakan Provider pattern.

**Isi**:
- `field1model`, `field2model`, `field3model`: State untuk menyimpan data dari API.

**Method**:
- `getTemperature()`: Fetch data suhu, update state dengan `notifyListeners()`.
- `getHumidity()`: Fetch data kelembaban udara, update state.
- `getSoilMoisture()`: Fetch data kelembaban tanah, update state.

**Pattern**: Menggunakan `ChangeNotifier` untuk reactivity Flutter UI.

---

### 4. `app_styles.dart` (lib/widget/)

**Kode Lengkap**:
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle roboto14Italic = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle roboto14 = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle roboto14SemiBold = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle roboto14Bold = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static TextStyle roboto16Italic = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle roboto16 = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle roboto16SemiBold = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle roboto16Bold = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static TextStyle whiteRoboto14Bold = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static Color mainColor = const Color(0xff36725D);
  static String loremIpsum = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String gambarThermometer = "thermometer.png";
  static String gambarSoilAnalysis = "soil_analysis.png";
  static String gambarSensorHumidity = "humidity_sensor.png";
}
```

**Fungsi**: Centralized styling & konfigurasi visual aplikasi.

**Isi**:
- `TextStyle` variants: `roboto14/16` dengan variasi font weight (w400/w500/w600/w700), plus `whiteRoboto14Bold`.
- `mainColor`: Warna tema aplikasi (hijau #36725D).
- `loremIpsum`: Teks placeholder untuk demo.
- `gambarThermometer/SoilAnalysis/SensorHumidity`: Nama file gambar asset (PNG).

**Dependency**: `google_fonts` package untuk custom typography.

---

### 5. `custom_read_field.dart` (lib/widget/)

**Kode Lengkap**:
```dart
import 'package:flutter/material.dart';

class CustomReadField extends StatelessWidget {
  String hasil;
  Color warnaBorder;
  String gambar;

  CustomReadField({
    super.key,
    required this.hasil,
    required this.warnaBorder,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: warnaBorder, width: 4),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 4,
            child: Image.asset(gambar, fit: BoxFit.fill),
          ),
          const SizedBox(height: 14),
          Center(child: Text(hasil)),
        ],
      ),
    );
  }
}
```

**Fungsi**: Custom reusable widget untuk tampilan card data sensor.

**Props**:
- `hasil`: String value untuk ditampilkan.
- `warnaBorder`: Color object untuk border color.
- `gambar`: String path gambar asset.

**Layout**:
- Container dengan border radius 24px & border width 4px.
- Image asset di atas (ukuran 1/4 lebar layar).
- Text di bawah (centered).
- Horizontal margin 24px.

---

### 6. `home_page.dart` (lib/screens/)

**Kode Lengkap**:
```dart
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
```

**Fungsi**: Halaman utama aplikasi untuk menampilkan data sensor.

**Layout**:
- AppBar dengan judul "Agro Tech" & warna tema.
- ListView vertical dengan 3 card `CustomReadField`:
  1. Data suhu (`field1model.field1`)
  2. Data kelembaban udara (`field2model.field2`)
  3. Data kelembaban tanah (`field3model.field3`)

**State**: Menggunakan `Consumer<AppProvider>` untuk subscribe perubahan state.

---

### 7. `splash_screen.dart` (lib/screens/)

**Kode Lengkap**:
```dart
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
```

**Fungsi**: Halaman awal saat aplikasi dibuka.

**Lifecycle**:
- `initState()`: Fetch semua data sensor (suhu, kelembaban, tanah) via `AppProvider`.

**Layout**:
- AppBar "Agro Tech".
- Text lorem ipsum (deskripsi aplikasi).
- Button "Continue" (hijau) untuk navigasi ke `HomePage`.

**Navigasi**: `SplashScreen` → `HomePage`.

---

### 8. `main.dart` (lib/)

**Kode Lengkap**:
```dart
import 'package:bab5/providers/app_provider.dart';
import 'package:bab5/screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  DevicePreview.enable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider()
            ..getTemperature()
            ..getHumidity()
            ..getSoilMoisture(),
        ),
      ],
      child: MaterialApp(
        title: "MCS BAB 5",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
```

**Fungsi**: Entry point aplikasi.

**Isi**:
- `main()`: Enable `DevicePreview` (untuk debugging responsive), jalankan `MyApp()`.
- `MyApp`: Stateful root widget.
  - `MultiProvider`: Inisialisasi `AppProvider` dengan fetch data di constructor.
  - `MaterialApp`: Set theme, title "MCS BAB 5", hide debug banner.
  - `home`: `SplashScreen`.

**Dependency**: `device_preview`, `provider` package.

---

## Struktur Data Flow

```
main.dart (init)
  → AppProvider.getTemperature/Humidity/SoilMoisture()
    → ApiService.getField1/2/3()
      → HTTP GET ke ThingSpeak API
        → JSON parse ke Field1/2/3Model
          → Update AppProvider state
            → Rebuild Consumer widgets (Splash/Home)
```

---

## Dependency Utama

- `flutter`: UI framework.
- `provider`: State management.
- `dio`: HTTP client.
- `google_fonts`: Typography.
- `device_preview`: Responsive debugging tool.

---

## Cara Menjalankan

1. Clone repo.
2. Install dependencies: `flutter pub get`.
3. Run: `flutter run`.
4. (Opsional) Debug dengan DevicePreview: gunakan web/mobile device preview mode.

---

## Catatan

- Read API key Hardcoded di `api_service.dart`.
- Channel ID ThingsPeak: 3550228.
- Gambar asset (PNG): thermometer.png, soil_analysis.png, humidity_sensor.png.
