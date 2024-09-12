import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmi = 0.0;
  String bmiCategory = "";
  String idealWeightRange = "";

  void calculateBMI() {
    final weight = double.tryParse(weightController.text) ?? 0.0;
    final height = double.tryParse(heightController.text) ?? 0.0;

    if (weight > 0 && height > 0) {
      final heightInMeters = height / 100;
      final calculatedBMI = weight / (heightInMeters * heightInMeters);

      setState(() {
        bmi = calculatedBMI;
        bmiCategory = getBMICategory(calculatedBMI);
        idealWeightRange = getIdealWeightRange(heightInMeters);
      });
    }
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Zayıf";
    if (bmi < 24.9) return "Normal";
    if (bmi < 29.9) return "Fazla Kilolu";
    return "Obez";
  }

  String getIdealWeightRange(double heightInMeters) {
    final minWeight = 18.5 * (heightInMeters * heightInMeters);
    final maxWeight = 24.9 * (heightInMeters * heightInMeters);
    return "İdeal Kilo Aralığı: ${minWeight.toStringAsFixed(2)} - ${maxWeight.toStringAsFixed(2)} kg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.calculate, size: 30, color: Colors.white),
        toolbarHeight: 60,
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text('İdeal Kilo Hesaplama', style: GoogleFonts.poppins(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'İdeal Kilo Hesaplama',
                          style: GoogleFonts.poppins(
                              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Lütfen bilgilerinizi girin:',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black54),
              ),
              SizedBox(height: 20),
              inputForm(
                  title: 'Kilo (kg)',
                  controller: weightController,
                  hintText: 'ör. 70'),
              inputForm(
                  title: 'Boy (cm)',
                  controller: heightController,
                  hintText: 'ör. 175'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700] ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Hesapla',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              bmi != 0.0
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sonuç:',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    idealWeightRange,
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'BMI: ${bmi.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kategori: $bmiCategory',
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputForm(
      {required String title,
        required TextEditingController controller,
        required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.black87),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hintText,
                contentPadding: EdgeInsets.symmetric(horizontal: 20)),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
