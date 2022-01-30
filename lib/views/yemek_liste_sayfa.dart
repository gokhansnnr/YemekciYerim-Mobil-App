import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/cubit/yemek_liste_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/entity/yemekler.dart';
import 'package:yemekciyerim_bitirmepr/repo/temel_yapilar_repo.dart';
import 'package:yemekciyerim_bitirmepr/views/sepet_sayfa.dart';
import 'package:yemekciyerim_bitirmepr/views/yemek_detay_sayfa.dart';

import 'anasayfa.dart';
import 'hesap_kayit_sayfa.dart';

class YemekListeSayfa extends StatefulWidget {
  String hesap;
  YemekListeSayfa({required this.hesap});

  @override
  _YemekListeSayfaState createState() => _YemekListeSayfaState();
}

class _YemekListeSayfaState extends State<YemekListeSayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<YemekListeCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TemelYapilarRenk().uygulamaAdi),
        titleTextStyle: TextStyle(
            fontFamily: TemelYapilarFont().logoYaziFont, fontSize: 24),
        centerTitle: true,
        backgroundColor: TemelYapilarRenk().anaRenk,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Anasayfa(hesap: widget.hesap)));
            },
            icon: Icon(Icons.home)),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.hesap == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Adres Bilgisi Eklememişsiniz.\nAdres Bilgisi Eklemek İster Misiniz ?"),
                    action: SnackBarAction(
                      label: "Evet",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HesapKayitSayfa()));
                      },
                    ),
                  ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SepetSayfa(hesap: widget.hesap)));
                }
              },
              icon: Icon(Icons.shopping_basket))
        ],
      ),
      body: BlocBuilder<YemekListeCubit, List<Yemekler>>(
          builder: (context, yemeklerListesi) {
        if (yemeklerListesi.isNotEmpty) {
          return ListView.builder(
            itemCount: yemeklerListesi.length,
            itemBuilder: (context, indeks) {
              var yemek = yemeklerListesi[indeks];
              return GestureDetector(
                  onTap: () {
                    if (widget.hesap == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Adres Bilgisi Eklememişsiniz.\nAdres Bilgisi Eklemek İster Misiniz ?"),
                        action: SnackBarAction(
                          label: "Evet",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HesapKayitSayfa()));
                          },
                        ),
                      ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YemekDetaySayfa(
                                  yemek: yemek, hesap: widget.hesap)));
                    }
                  },
                  child: Card(
                    child: SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 110,
                              width: 110,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: TemelYapilarRenk().gorselArkaRenk,
                                      boxShadow: [
                                        BoxShadow(
                                            color: TemelYapilarRenk()
                                                .gorselGolgeRenk,
                                            spreadRadius: 3),
                                      ],
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          "assets/resimler/loading.gif",
                                      image:
                                          "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                      fit: BoxFit.fill,
                                    )),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${yemek.yemek_adi}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color:
                                            TemelYapilarRenk().kategoriAdiRenk),
                                  ),
                                  Text("${yemek.yemek_fiyat} ₺",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: TemelYapilarRenk()
                                              .kategoriFiyatRenk)),
                                ]),
                          ),
                          Container(
                              color: TemelYapilarRenk().kategoriCubukRenk,
                              height: 120,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: TemelYapilarRenk().kategoriIkonRenk,
                              )),
                        ],
                      ),
                    ),
                  ));
            },
          );
        } else {
          return Center();
        }
      }),
    );
  }
}
