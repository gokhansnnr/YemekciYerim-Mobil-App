import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/cubit/yemek_detay_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/entity/sepet_yemekler.dart';
import 'package:yemekciyerim_bitirmepr/repo/temel_yapilar_repo.dart';
import 'package:yemekciyerim_bitirmepr/repo/yemeklerdao_repo.dart';

class SepetYemekDetaySayfa extends StatefulWidget {
  String hesap;
  SepetYemekler sepetYemekler;

  SepetYemekDetaySayfa({required this.sepetYemekler, required this.hesap});

  @override
  _SepetYemekDetaySayfaState createState() => _SepetYemekDetaySayfaState();
}

class _SepetYemekDetaySayfaState extends State<SepetYemekDetaySayfa> {
  int gosterge = 1;
  @override
  void initState() {
    super.initState();
    var sepetYemekler = widget.sepetYemekler;
    gosterge = int.parse(widget.sepetYemekler.yemek_siparis_adet);
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    int urunTutar = YemeklerDaoRepo().urunFiyatHesaplama(
        fiyat: widget.sepetYemekler.yemek_fiyat, adet: gosterge.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(TemelYapilarRenk().uygulamaAdi),
        titleTextStyle: TextStyle(
            fontFamily: TemelYapilarFont().logoYaziFont, fontSize: 24),
        centerTitle: true,
        backgroundColor: TemelYapilarRenk().anaRenk,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: ekranGenisligi / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 250,
                    width: ekranGenisligi / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: TemelYapilarRenk().gorselArkaRenk,
                            boxShadow: [
                              BoxShadow(
                                  color: TemelYapilarRenk().gorselGolgeRenk,
                                  spreadRadius: 3),
                            ],
                          ),
                          child: FadeInImage.assetNetwork(
                              placeholder: "assets/resimler/loading.gif",
                              image:
                                  "http://kasimadalan.pe.hu/yemekler/resimler/${widget.sepetYemekler.yemek_resim_adi}",
                              fit: BoxFit.cover)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 6, bottom: 6),
                            child: Text(
                              widget.sepetYemekler.yemek_adi,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                              width: 60,
                              child: Text(
                                "${widget.sepetYemekler.yemek_fiyat} ₺",
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        TemelYapilarRenk().kategoriFiyatRenk2,
                                    fontWeight: FontWeight.bold),
                              ))
                        ]),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                      bottom: BorderSide(width: 2.0, color: Color(0xFFD72816)),
                    ))),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 6),
                      child: Text(
                        "Ürününüzün Tutarı :",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        "$urunTutar ₺",
                        style: TextStyle(
                            fontSize: 20,
                            color: TemelYapilarRenk().kategoriFiyatRenk2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                  bottom: BorderSide(width: 2.0, color: Color(0xFFD72816)),
                ))),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Ürün Adedini Belirleyiniz:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            gosterge += 1;
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 24,
                        )),
                    Text(
                      "$gosterge",
                      style: TextStyle(
                          fontSize: 22,
                          color: TemelYapilarRenk().anaRenk,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          if (gosterge <= 0) {
                            gosterge = 0;
                          } else {
                            setState(() {
                              gosterge -= 1;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 24,
                        )),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (gosterge == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Ürün adetini 0 girdiğiniz için ürün sepetinize eklenmemiştir.",
                              textAlign: TextAlign.center),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Ürün Sepetinize Eklenmiştir",
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.green,
                        ));
                        var yemek_siparis_adet = gosterge;
                        var kullanici_adi = widget.hesap;
                        context.read<YemekDetayCubit>().guncelle(
                            widget.sepetYemekler.sepet_yemek_id,
                            widget.sepetYemekler.yemek_adi,
                            widget.sepetYemekler.yemek_resim_adi,
                            widget.sepetYemekler.yemek_fiyat,
                            yemek_siparis_adet,
                            kullanici_adi);
                      }
                    },
                    child: Text("Sepete Ekleyin",
                        style: TextStyle(
                            color: TemelYapilarRenk().varsayilanButonYaziRenk)),
                    style: ElevatedButton.styleFrom(
                      primary: TemelYapilarRenk().varsayilanButonRenk,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
