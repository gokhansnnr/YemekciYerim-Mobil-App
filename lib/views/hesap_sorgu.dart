import 'package:flutter/material.dart';
import 'package:yemekciyerim_bitirmepr/repo/temel_yapilar_repo.dart';
import 'package:yemekciyerim_bitirmepr/views/hesap_kayit_sayfa.dart';

import 'anasayfa.dart';

class HesapSorgu extends StatefulWidget {
  const HesapSorgu({Key? key}) : super(key: key);

  @override
  _HesapSorguState createState() => _HesapSorguState();
}

class _HesapSorguState extends State<HesapSorgu> {
  String hesap = "";
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Scaffold(
        /*appBar: AppBar(
          title: Text(TemelYapilarRenk().uygulamaAdi),
          centerTitle: true,
          backgroundColor: TemelYapilarRenk().anaRenk,
        ),*/
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: ekranGenisligi / 2,
            height: ekranGenisligi / 2,
            child: Image.asset(
              "assets/resimler/android_app_icon1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 10),
            child: Text(TemelYapilarRenk().uygulamaAdi,
                style: TextStyle(
                  fontFamily: TemelYapilarFont().logoYaziFont,
                  fontSize: 32,
                  color: TemelYapilarRenk().anaRenk,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Text(
              "Giriş Yönteminizi Seçiniz",
              style: TextStyle(
                  color: TemelYapilarRenk().kategoriFiyatRenk,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Anasayfa(hesap: hesap)));
              },
              child: Text(
                "Kullanıcı Adı Belirtmeden Devam Et",
                style:
                    TextStyle(color: TemelYapilarRenk().anaRenk, fontSize: 18),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HesapKayitSayfa()));
              },
              child: Text(
                "Kullanıcı Adı Belirterek Devam Et",
                style:
                    TextStyle(color: TemelYapilarRenk().anaRenk, fontSize: 18),
              ))
        ],
      ),
    ));
  }
}
