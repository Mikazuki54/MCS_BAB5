# Agro Tech - Monitoring Pertanian IoT

Aplikasi Flutter untuk memantau parameter lingkungan pertanian (suhu, kelembaban tanah, kelembaban udara) melalui API ThingSpeak.

---

## Package yang Digunakan

- `flutter`: Framework UI untuk membangun aplikasi.
- `cupertino_icons`: Ikon bergaya Cupertino untuk iOS.
- `google_fonts`: Menyediakan font Roboto pada tampilan aplikasi.
- `provider`: State management dan dependency injection.
- `dio`: HTTP client untuk mengambil data dari API ThingSpeak.
- `device_preview`: Preview tampilan aplikasi pada berbagai ukuran perangkat.
- `flutter_test`: Fitur pengujian aplikasi Flutter.
- `flutter_lints`: Aturan lint untuk menjaga kualitas kode Dart/Flutter.

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
        field1: json["field1"] ?? "0",
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
        field2: json["field2"] ?? "0",
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
        field3: json["field3"] ?? "0",
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field3": field3,
    };
}
```

**Penjelasan Lengkap**:

File ini berisi tiga model data (`Field1Model`, `Field2Model`, `Field3Model`) yang merepresentasikan struktur data yang dikembalikan oleh API ThingSpeak untuk setiap field sensor. Setiap model memiliki properti yang sama: `createdAt` (waktu pengiriman data), `entryId` (urutan entri), dan `fieldX` (nilai sensor).

Model `Field1Model` digunakan untuk data suhu (field ke-1), `Field2Model` untuk kelembaban udara (field ke-2), dan `Field3Model` untuk kelembaban tanah (field ke-3). Struktur ini memudahkan pengelompokan berdasarkan tipe data sensor meskipun format response API-nya sama.

Setiap model memiliki dua helper function: `xxxModelFromJson(String)` dan `xxxModelToJson(Model)`. Function `FromJson` mengkonversi string JSON yang diterima dari API menjadi object model Dart. Prosesnya: string JSON di-decode menggunakan `json.decode()` dari package `dart:convert` menjadi `Map<String, dynamic>`, lalu di-pass ke factory constructor `fromJson()` untuk membuat instance model. Function `ToJson` melakukan proses sebaliknya: mengkonversi object model kembali menjadi string JSON menggunakan `json.encode()` setelah memanggil method `toJson()` yang menghasilkan map.

Factory constructor `fromJson(Map<String, dynamic> json)` bertanggung jawab membuat instance model dari map. Setiap properti di-assign dari map dengan mapping key yang sesuai: `created_at` untuk waktu (dikonversi ke `DateTime` menggunakan `DateTime.parse()`), `entry_id` untuk ID entri, dan `fieldX` untuk nilai sensor. Ini menangani konversi tipe data otomatis: string ke DateTime untuk `createdAt`, integer ke int untuk `entryId`, dan string ke String untuk `fieldX`.

Method `toJson()` mengembalikan `Map<String, dynamic>` yang berisi representasi serialisasi dari object. Setiap properti dikonversi kembali ke format JSON-compatible: `DateTime` dikonversi ke string ISO 8601 menggunakan `toIso8601String()`, integer tetap integer, dan string tetap string. Map ini kemudian di-encode menjadi string JSON oleh helper function eksternal.

Pola ini mengikuti best practice Flutter/Dart untuk parsing JSON: setiap model memiliki factory constructor untuk parsing dan method untuk serialisasi, plus helper function eksternal untuk convenience. Ini memudahkan penggunaan: cukup panggil `field1ModelFromJson(response.body)` untuk parsing dan `field1ModelToJson(model)` untuk serialisasi jika perlu mengirim data kembali (meskipun dalam kasus read-only API ThingSpeak, serialisasi jarang digunakan).

---

### 2. `api_service.dart` (lib/services/)

**Kode Lengkap**:
```dart
import 'package:bab5/models/field_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  static const _baseUrl =
      'https://api.thingspeak.com/channels/3550228/fields';
  static const _readKey = 'GJALAA6FCFQWBJ6M';

  Future<T> _getField<T>(
    int field,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await dio.get(
      '$_baseUrl/$field/last.json',
      queryParameters: {'api_key': _readKey},
    );

    return fromJson(Map<String, dynamic>.from(response.data));
  }

  Future<Field1Model> getField1() =>
      _getField<Field1Model>(1, Field1Model.fromJson);

  Future<Field2Model> getField2() =>
      _getField<Field2Model>(2, Field2Model.fromJson);

  Future<Field3Model> getField3() =>
      _getField<Field3Model>(3, Field3Model.fromJson);
}
```

**Penjelasan Lengkap**:

File ini berisi `ApiService` class yang bertugas melakukan komunikasi HTTP dengan API ThingSpeak untuk mengambil data sensor terakhir. Class ini menggunakan library `Dio` sebagai HTTP client yang lebih powerful dan user-friendly dibanding `HttpClient` bawaan Flutter.

`Dio` adalah HTTP client untuk Dart yang mendukung interseptor, form encoding, JSON parsing, timeout, cancellation, dan lain-lain. Instance `final Dio dio = Dio()` dibuat sebagai class member untuk reuse connection pool dan konfigurasi default.

`_readKey` adalah API key read-only untuk mengakses channel ThingSpeak. API key ini diperlukan oleh ThingSpeak untuk autentikasi request read. Dalam production, API key sebaiknya tidak hardcode di source code, tapi disimpan di environment variable atau menggunakan secure storage. Untuk dev/debug, hardcode acceptable.

`_baseUrl` adalah URL dasar endpoint ThingSpeak (`https://api.thingspeak.com/channels/3550228/fields`). Nomor field ditambahkan secara dinamis oleh method `_getField()`, sehingga URL tidak perlu ditulis berulang. Channel ID 3550228 adalah ID channel yang digunakan, field 1 untuk suhu, field 2 untuk kelembaban udara, dan field 3 untuk kelembaban tanah. `_readKey` dikirim melalui `queryParameters`, sehingga Dio membentuk parameter `?api_key=...` secara otomatis.

Method `_getField()` adalah generic helper method untuk mengambil dan mengubah data JSON menjadi model sesuai field yang diminta. Method `getField1()`, `getField2()`, dan `getField3()` memanggil `_getField()` dengan nomor field dan factory `fromJson` masing-masing model.

Response `response.data` dari Dio dikonversi menjadi `Map<String, dynamic>` menggunakan `Map<String, dynamic>.from(response.data)` sebelum dikirim ke `fromJson()`.

Pattern ini mengikuti best practice untuk API service: separate concern antara HTTP communication dan business logic, hindari duplikasi kode dengan helper method, dan gunakan async/await untuk non-blocking I/O.

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

**Penjelasan Lengkap**:

File ini berisi `AppProvider` class yang bertindak sebagai state management layer menggunakan Pattern Provider (dari package `provider`). Class ini meng-extends `ChangeNotifier` dari Flutter framework, yang merupakan implementasi dari observer pattern untuk reactivity UI.

`AppProvider` menyimpan tiga state property: `field1model`, `field2model`, `field3model` yang bertipe `Field1Model?`, `Field2Model?`, `Field3Model?` (nullable). Property nullable (`?`) menunjukkan bahwa nilai awal belum tersedia (null) sampai data berhasil di-fetch dari API. Ini penting untuk handling loading state di UI.

`getTemperature()`, `getHumidity()`, `getSoilMoisture()` adalah async method yang mengambil data dari API dan update state. Prosesnya: 1) Panggil `notifyListeners()` untuk memberitahu Flutter bahwa state akan berubah (ini trigger re-render widgets yang listen ke provider), 2) Fetch data menggunakan `ApiService().getFieldX()`, 3) Assign hasil ke state property `fieldXmodel`.

Penting: `notifyListeners()` dipanggil **sebelum** fetch data, bukan sesudah. Ini adalah pola umum untuk loading state: UI langsung re-render (biasanya tampilkan loading indicator) sebelum data masuk. Setelah fetch selesai, assign ke property, dan karena property adalah class member, Flutter sudah notify listeners. Jika `notifyListeners()` dipanggil setelah assign, tidak ada effect karena tidak ada perubahan state (setter dipanggil tapi notification tidak di-trigger otomatis oleh Dart).

Async/await digunakan untuk menangani I/O yang tidak-blocking. `await ApiService().getField1()` menunggu HTTP request selesai, lalu assign hasil ke `field1model`. Return type `Future` memungkinkan caller menunggu atau tidak menunggu hasil (misal: di `initState()`, caller tidak tunggu).

`notifyListeners()` adalah method dari `ChangeNotifier` yang memberitahu semua listener (widgets yang subscribe via `Consumer` atau `Provider.of`) bahwa state berubah dan mereka harus rebuild. Ini adalah inti dari reactivity Flutter: provider notify, consumer rebuild.

Pattern ini mengikuti best practice state management Flutter: gunakan `ChangeNotifierProvider` untuk simple state, separate business logic (fetch data) dari UI, dan gunakan `notifyListeners()` untuk trigger reactivity.

---

### 4. `app_styles.dart` (lib/widget/)

**Kode Lengkap**:
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle normalTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle boldTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle whiteBoldTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static Color mainColor = const Color(0xff36725D);
  static String loremIpsum = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String gambarThermometer = "thermometer.png";
  static String gambarSoilAnalysis = "soil_analysis.png";
  static String gambarSensorHumidity = "humidity_sensor.png";
}
```

**Penjelasan Lengkap**:

File ini berisi `AppStyles` class yang berfungsi sebagai centralized style configuration untuk aplikasi. Ini adalah implementasi dari design system pattern: semua style visual (typography, color, asset path) dikumpulkan di satu tempat untuk mudah di-maintain dan konsisten.

`GoogleFonts.roboto()` adalah factory constructor dari package `google_fonts` yang menghasilkan `TextStyle` object dengan font Roboto. Font Roboto adalah default Google font yang clean dan modern, cocok untuk aplikasi profesional.

AppStyles menyediakan **3 TextStyle utama**:
- `normalTextStyle`: Roboto font 14sp dengan weight `FontWeight.w500` (medium) untuk text normal/regular. Digunakan untuk body text dan content umum.
- `boldTextStyle`: Roboto font 14sp dengan weight `FontWeight.bold` untuk text yang perlu emphasis. Digunakan untuk judul, label, dan heading minor.
- `whiteBoldTextStyle`: Roboto font 14sp dengan weight `FontWeight.bold` dan warna putih (`Colors.white`). Khusus untuk teks di atas background gelap (AppBar, button) agar kontras dan readable.

Naming convention menggunakan format deskriptif camelCase (`[color][weight]TextStyle`) sehingga mudah dibaca dan agnostik terhadap jenis font jika suatu saat font diganti.

`mainColor` adalah warna tema utama aplikasi (hijau #36725D). Ini digunakan di berbagai tempat (AppBar, button, border) untuk konsistensi visual. Warna hex `0xff36725D` adalah format ARGB (Alpha, Red, Green, Blue) dengan Alpha 255 (opaque). Pemilihan warna hijau sesuai dengan tema pertanian/agrikultur.

`loremIpsum` adalah string placeholder text (standard Lorem Ipsum) yang digunakan untuk demo atau space-filling di UI sebelum data asli tersedia. Ini memungkinkan developer melihat layout tanpa data.

`gambarThermometer/SoilAnalysis/SensorHumidity` adalah nama file gambar asset (PNG) yang digunakan untuk ikon sensor di UI. Path relatif ke asset folder, dan digunakan dengan `Image.asset()` widget.

Pattern ini mengikuti best practice Flutter: gunakan centralized style configuration untuk maintainability, gunakan `google_fonts` untuk custom typography, dan kurangi kompleksitas dengan hanya 3 style utama yang reusable.

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

**Penjelasan Lengkap**:

File ini berisi `CustomReadField` class yang merupakan custom reusable widget untuk menampilkan data sensor dalam format card. Ini adalah implementasi dari DRY (Don't Repeat Yourself) principle: widget yang sering digunakan dibuat satu kali dan di-reuse di banyak tempat.

`CustomReadField` adalah `StatelessWidget` karena isinya tidak berubah setelah dibuat. Widget ini menerima tiga props dari caller: `hasil` (string nilai sensor), `warnaBorder` (color untuk border card), `gambar` (string path gambar asset).

Constructor `CustomReadField()` memiliki `super.key` untuk support Flutter widget key system (untuk identity dan optimization), dan 3 required properties yang diassign ke class member.

Layout menggunakan `Container` sebagai parent widget dengan konfigurasi visual:
- `width: double.infinity`: Card memenuhi lebar available space.
- `margin: EdgeInsets.symmetric(horizontal: 24)`: Margin horizontal 24px untuk spacing dari edge screen.
- `padding: EdgeInsets.symmetric(vertical: 18)`: Padding vertical 18px untuk spacing internal.
- `decoration: BoxDecoration(...)`: Styling visual:
  - `borderRadius: BorderRadius.circular(24)`: Corner card dibuat membulat dengan radius 24px.
  - `border: Border.all(color: warnaBorder, width: 4)`: Border dengan warna dan ketebalan yang configurable.

`Column` child digunakan untuk layout vertical: gambar di atas, text di bawah.
- `SizedBox` dengan `width` dan `height` = `MediaQuery.of(context).size.width / 4`: Ukuran gambar relative terhadap lebar layar (1/4 lebar). Ini responsive: gambar mengecil/membesar mengikuti ukuran layar.
- `Image.asset(gambar, fit: BoxFit.fill)`: Widget untuk menampilkan gambar asset. `fit: BoxFit.fill` membuat gambar memenuhi SizedBox tanpa preserve aspect ratio.
- `SizedBox(height: 14)`: Spacing antara gambar dan text.
- `Center(child: Text(hasil))`: Widget text dengan posisi center.

`MediaQuery.of(context).size.width` adalah cara Flutter mendapatkan lebar layar saat ini. Ini memungkinkan widget responsive terhadap ukuran layar berbeda (mobile, tablet, desktop).

Pattern ini mengikuti best practice Flutter: gunakan `StatelessWidget` untuk UI statis, gunakan `Container` dengan `BoxDecoration` untuk styling, gunakan `MediaQuery` untuk responsive layout, dan gunakan named properties untuk konfigurasi.

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
            title: Text("Agro Tech", style: AppStyles.whiteBoldTextStyle),
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
```

**Penjelasan Lengkap**:

File ini berisi `HomePage` class yang merupakan halaman utama aplikasi untuk menampilkan data sensor real-time. Ini adalah widget utama yang menerima data dari `AppProvider` dan menampilkannya menggunakan `CustomReadField`.

`HomePage` adalah `StatelessWidget` karena UI tidak berubah internal; perubahan dirender oleh `Consumer` yang rebuild widget setiap kali state di `AppProvider` berubah. Ini adalah pattern Flutter: stateless UI dengan stateful provider.

`Consumer<AppProvider>` adalah widget dari package `provider` yang listen ke `AppProvider`. Setiap kali `notifyListeners()` dipanggil di `AppProvider`, `Consumer` trigger rebuild widget dan pass `appProvider` object ke builder function.

`Scaffold` adalah widget dasar Material Design layout structure. Ini menyediakan struktur dasar: AppBar, body, floatingActionButton, dsb.
- `appBar`: AppBar dengan judul "Agro Tech" (menggunakan style dari `AppStyles.whiteBoldTextStyle` agar teks putih), centered title, no automatic back button (`automaticallyImplyLeading: false` karena ini adalah halaman utama), background color `AppStyles.mainColor`.
- `body`: Bagian utama halaman.

`body` menggunakan `Center` child `ListView` untuk layout vertical scrollable.
- `shrinkWrap: true`: ListView hanya memakan space sebesar content-nya (tidak expand ke full height). Ini penting karena ListView ada di dalam widget lain (Center).
- `children`: List widget vertikal:
  1. `CustomReadField` untuk suhu: ambil `field1model!.field1` (non-null assertion operator `!` karena kita yakin data sudah ada setelah fetch), border `mainColor`, gambar `thermometer.png`.
  2. `SizedBox(height: 20)`: Spacing 20px antar card.
  3. `CustomReadField` untuk kelembaban udara: `field2model!.field2`.
  4. `SizedBox(height: 20)`.
  5. `CustomReadField` untuk kelembaban tanah: `field3model!.field3`.

Non-null assertion operator `!` digunakan karena `fieldXmodel` adalah nullable. Dalam kasus ini, kita yakin bahwa `initState()` di `SplashScreen` sudah memanggil `getTemperature()` dsb sebelum navigasi ke `HomePage`, jadi data sudah tersedia. Jika data belum tersedia (null), aplikasi akan throw runtime error. Untuk production, sebaiknya handle null case dengan conditional atau default value.

Pattern ini mengikuti best practice Flutter: gunakan `Consumer` untuk reactive UI, gunakan `Scaffold` untuk layout struktur, gunakan `ListView` untuk scrollable content, dan gunakan `!` operator dengan hati-hati.

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
```

**Penjelasan Lengkap**:

File ini berisi `SplashScreen` class yang merupakan halaman pertama yang ditampilkan saat aplikasi dibuka. Ini berfungsi sebagai loading screen untuk fetch data awal sebelum navigasi ke `HomePage`.

`SplashScreen` adalah `StatefulWidget` karena butuh lifecycle management (`initState()`). Class `SplashScreen` adalah immutable widget, class `_SplashScreenState` adalah mutable state.

`initState()` adalah lifecycle method yang dipanggil sekali saat widget dimasukkan ke tree. Ini adalah tempat ideal untuk inisialisasi: fetch data, subscribe event, dsb.
- `WidgetsBinding.instance.addPostFrameCallback((_) { ... })`: Jalankan API call setelah frame selesai render (hindari error `notifyListeners` dipanggil saat build).
- `context.read<AppProvider>()`: Ambil `AppProvider` tanpa subscribe ke perubahan (ekivalen `Provider.of(context, listen: false)`). Cascade notation `..` dipakai untuk chain 3 method fetch data secara berurutan.

`Scaffold` dengan layout:
- `appBar`: Sama seperti di `HomePage` (judul, centered, warna tema).
- `body`: `Center` child `ListView` dengan `shrinkWrap: true` dan `physics: NeverScrollableScrollPhysics()` (tidak scrollable).

Content dalam `ListView`:
- `Text(AppStyles.loremIpsum)`: Teks placeholder deskripsi aplikasi. `textAlign: TextAlign.justify` membuat teks rata kiri-kanan (full justify).
- `SizedBox(height: 30)`: Spacing antara text dan button.
- `Align` dengan `alignment: Alignment.centerRight`: Button di posisi kanan (ganti dari `Row` + `mainAxisAlignment: MainAxisAlignment.end`).
- `GestureDetector`: Widget untuk detect tap event. `onTap()` adalah callback saat user tap.
- `Container` di dalam `GestureDetector`: Styling button dengan padding, border radius 24px (pill shape), warna tema, dan teks putih "Continue".

`onTap` event handler: `Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()))`. Ini navigasi ke `HomePage` dengan animasi Material Design default.

**Optimasi**:
- Hapus `Consumer<AppProvider>` (UI splash tidak menampilkan data, tidak perlu listen).
- Hapus `Padding` wrapper (ganti dengan `padding` langsung di `ListView`).
- Hapus `margin` duplikat dari `Container` (padding sudah cukup).
- Ganti `Row` + `mainAxisAlignment: MainAxisAlignment.end` ke `Align` (lebih singkat).
- Ganti `Provider.of(context, listen: false)` ke `context.read()` (style lebih modern).

Pattern ini mengikuti best practice Flutter: gunakan `StatefulWidget` untuk lifecycle management, gunakan `initState()` untuk inisialisasi async, gunakan `addPostFrameCallback` untuk avoid build-time `notifyListeners` error, gunakan `Navigator` untuk routing, dan gunakan `GestureDetector` untuk interactive widget.

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

**Penjelasan Lengkap**:

File ini berisi entry point aplikasi (`main()`) dan root widget (`MyApp`). Ini adalah file pertama yang dijalankan saat aplikasi启动.

`main()` function adalah entry point Dart/Flutter aplikasi. Ini dipanggil pertama kali saat aplikasi启动.
- `DevicePreview.enable()`: Enable `device_preview` package yang memungkinkan preview aplikasi di berbagai ukuran device langsung di desktop (browser). Ini sangat berguna untuk testing responsive layout tanpa perlu emulasi device. Ini adalah development-only feature (tidak affecting production).
- `runApp(MyApp())`: Start Flutter aplikasi dengan `MyApp` sebagai root widget.

`MyApp` adalah `StatelessWidget` root widget. Ini adalah widget yang mencakup seluruh aplikasi.

`MultiProvider` adalah widget dari package `provider` yang menyediakan multiple providers ke subtree. Ini adalah pattern untuk dependency injection: providers di-inject ke widget tree, dan widgets di bawah bisa access providers dengan `Consumer` atau `Provider.of()`.
- `ChangeNotifierProvider<AppProvider>(create: (context) => AppProvider()..getTemperature()..getHumidity()..getSoilMoisture())`: Buat instance `AppProvider` dan inject ke subtree. `create` function dipanggil sekali saat widget pertama kali dibuat (bukan saat rebuild). `..` operator (cascade notation) digunakan untuk memanggil method pada object yang sama tanpa perlu repeat `AppProvider()`: `AppProvider()..getTemperature()` = buat instance, panggil `getTemperature()`, return instance.

Method chaining `getTemperature()..getHumidity()..getSoilMoisture()` memanggil semua 3 method fetch data secara berurutan. Ini parallel operation? Tidak. `..` operator adalah sequential: `getTemperature()` dipanggil, tunggu (async), lalu `getHumidity()`, lalu `getSoilMoisture()`. Untuk parallel, sebaiknya gunakan `Future.wait()` atau gunakan `async` di `create` function dengan `FutureProvider`. Tapi untuk simple app, sequential acceptable karena data small dan fast to fetch.

`MaterialApp` adalah root widget Material Design aplikasi. Ini menyediakan konfigurasi global untuk aplikasi.
- `title: "MCS BAB 5"`: Aplikasi title (untuk accessibility, task switcher, dsb).
- `debugShowCheckedModeBanner: false`: Hide debug banner di pojok kiri atas (standard Flutter debug banner).
- `theme: ThemeData(...)`: Konfigurasi themeMaterial Design.
  - `colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)`: Generate color scheme dari seed color deep purple. Ini otomatis generate primary, secondary, background, dsb warna.
  - `useMaterial3: true`: Gunakan Material Design 3 (latest Material Design).
- `home: const SplashScreen()`: Set `SplashScreen` sebagai halaman pertama (route awal).

Pattern ini mengikuti best practice Flutter: gunakan `runApp()` untuk start aplikasi, gunakan `MultiProvider` untuk state management injection, gunakan `MaterialApp` untuk Material Design theme, dan gunakan cascade notation untuk concise initialization.

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

**Penjelasan Flow**:

1. **Entry Point (`main.dart`)**: `main()` function enable `DevicePreview`, lalu `runApp(MyApp())`. `MyApp` rebuild dengan `MultiProvider` yang inject `AppProvider`.

2. **Provider Inisialisasi**: `ChangeNotifierProvider` call `create()` function, buat `AppProvider()` instance, lalu chain `getTemperature()..getHumidity()..getSoilMoisture()`.

3. **API Service Call**: Setiap `getFieldX()` method melakukan HTTP GET request ke ThingSpeak API dengan URL yang sesuai dan API key. Response (JSON string) dikembalikan oleh `Dio`.

4. **JSON Parsing**: Response data di-parse ke model object (`Field1Model`, `Field2Model`, `Field3Model`) menggunakan factory constructor `FieldXModel.fromJson()`. Ini convert JSON map ke Dart object dengan tipe yang safe.

5. **State Update**: Hasil parsing assign ke `fieldXmodel` property di `AppProvider`. Karena `notifyListeners()` dipanggil sebelum fetch, Flutter sudah notify listeners (untuk loading state), lalu assign data.

6. **UI Rebuild**: Widgets yang listen ke `AppProvider` (via `Consumer` atau `Provider.of`) rebuild otomatis. `HomePage` menampilkan data sensor dengan `CustomReadField` widget.

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
