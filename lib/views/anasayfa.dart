import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yemekciyerim_bitirmepr/repo/hesaplar_repo.dart';
import 'package:yemekciyerim_bitirmepr/repo/temel_yapilar_repo.dart';
import 'package:yemekciyerim_bitirmepr/views/yemek_liste_sayfa.dart';

import 'hesap_kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  String hesap;
  Anasayfa({required this.hesap});

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    bool hesapAcilmisMi =
        HesaplarDaoRepo().hesapAcikKontrol(hesap: widget.hesap);
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(TemelYapilarRenk().uygulamaAdi),
        titleTextStyle: TextStyle(
            fontFamily: TemelYapilarFont().logoYaziFont, fontSize: 24),
        centerTitle: true,
        backgroundColor: TemelYapilarRenk().anaRenk,
        actions: [
          hesapAcilmisMi
              ? Container(
                  height: 0,
                  width: 0,
                )
              : IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HesapKayitSayfa()));
                  },
                  icon: Icon(Icons.person))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              child: SizedBox(
                  height: 400,
                  width: ekranGenisligi / 1.12,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 3.0, color: Color(0xFFD72816)),
                      left: BorderSide(width: 3.0, color: Color(0xFFD72816)),
                      right: BorderSide(width: 3.0, color: Color(0xFFD72816)),
                      bottom: BorderSide(width: 3.0, color: Color(0xFFD72816)),
                    )),
                    child: Image.asset(
                      "assets/resimler/anasayfa_animasyon.gif",
                      //fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SizedBox(
                height: 60,
                width: ekranGenisligi / 1.12,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                YemekListeSayfa(hesap: widget.hesap)));
                  },
                  child: Text(
                    "Hemen Sipariş Verin",
                    style: TextStyle(
                        color: TemelYapilarRenk().varsayilanButonYaziRenk,
                        fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: TemelYapilarRenk().varsayilanButonRenk,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                child: hesapAcilmisMi
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.hesap,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.person,
                            size: 30,
                            color: TemelYapilarRenk().altMenuSeciliRenk,
                          )
                        ],
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ))
          ],
        ),
      ),
    );
  }
}
