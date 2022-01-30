import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/cubit/hesap_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/repo/temel_yapilar_repo.dart';
import 'package:yemekciyerim_bitirmepr/views/anasayfa.dart';

class HesapKayitSayfa extends StatefulWidget {
  @override
  _HesapKayitSayfaState createState() => _HesapKayitSayfaState();
}

class _HesapKayitSayfaState extends State<HesapKayitSayfa> {
  var tfKullaniciAdiController = TextEditingController();
  var tfacikAdresController = TextEditingController();
  var tfIlceController = TextEditingController();
  var tfIlController = TextEditingController();
  var tfTelefonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TemelYapilarRenk().uygulamaAdi),
        titleTextStyle: TextStyle(
            fontFamily: TemelYapilarFont().logoYaziFont, fontSize: 24),
        centerTitle: true,
        backgroundColor: TemelYapilarRenk().anaRenk,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 14),
                child: TextField(
                  controller: tfKullaniciAdiController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Kullanıcı Adınızı Giriniz",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: tfacikAdresController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Adres Bilginizi Giriniz",
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: tfIlceController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "İlçe",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: tfIlController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "İl",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 14),
                child: TextField(
                  controller: tfTelefonController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Telefon Numaranız",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (tfKullaniciAdiController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Metin Alanlarını Boş Bırakmayınız.",
                                  textAlign: TextAlign.center),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Kayıt Başarılı",
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                            ));
                            setState(() {});
                          }
                          setState(() {
                            FocusScope.of(context).requestFocus(FocusNode());
                            context.read<HesapSayfaCubit>().kayit(
                                tfKullaniciAdiController.text,
                                tfacikAdresController.text,
                                tfIlceController.text,
                                tfIlController.text,
                                tfTelefonController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Anasayfa(
                                        hesap: tfKullaniciAdiController.text)));
                          });
                        },
                        child: Text("Kaydet",
                            style: TextStyle(
                                color: TemelYapilarRenk()
                                    .varsayilanButonYaziRenk)),
                        style: ElevatedButton.styleFrom(
                          primary: TemelYapilarRenk().varsayilanButonRenk,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
