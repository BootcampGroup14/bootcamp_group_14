import 'package:flutter/material.dart';

class SifremiUnuttumSayfasi extends StatefulWidget {
  const SifremiUnuttumSayfasi({super.key});

  @override
  State<SifremiUnuttumSayfasi> createState() => _SifremiUnuttumSayfasiState();
}

class _SifremiUnuttumSayfasiState extends State<SifremiUnuttumSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: Stack( 
          children: [

            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/Login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),



            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100.0),
                    Center(
                      child: Text(
                        "Şifremi Unuttum",
                        style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),

                    // Açıklama
                    SizedBox(height: 40.0),
                    Text(
                      "E-posta adresinize parolanızı sıfırlamak için bir kod göndereceğiz.",
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),

                    // E-posta kutusu
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "E-posta",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0), // Yüksekliği azaltmak için padding ayarı
                      ),
                    ),


                    SizedBox(height: 50.0),
                    Center(
                      child: SizedBox(
                        width: 400.0,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text(
                            "Gönder",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
