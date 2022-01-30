import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/cubit/sepet_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/entity/sepet_yemekler.dart';
import 'package:yemekciyerim_bitirmepr/repo/temel_yapilar_repo.dart';
import 'package:yemekciyerim_bitirmepr/repo/yemeklerdao_repo.dart';
import 'package:yemekciyerim_bitirmepr/views/sepet_yemek_detay_sayfa.dart';
import 'package:yemekciyerim_bitirmepr/views/yemek_liste_sayfa.dart';

class SepetSayfa extends StatefulWidget {
  String hesap;

  SepetSayfa({required this.hesap});

  @override
  _SepetSayfaState createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  int urunFiyat = 0;
  int toplamUrunFiyat = 0;
  var yemekListe = [];
  var sepetIndex = [];

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYukle(widget.hesap);
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
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
        actions: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: BlocBuilder<SepetSayfaCubitIslem, int>(
                    builder: (context, islem) {
                  if (islem == 0) {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  } else {
                    return Text(
                      "$islem ₺",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: TemelYapilarRenk().gorselGolgeRenk),
                    );
                  }
                }),
              ))
        ],
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
          builder: (context, sepettekilerListesi) {
        if (sepettekilerListesi.isNotEmpty) {
          return ListView.builder(
              itemCount: sepettekilerListesi.length,
              itemBuilder: (context, indeks) {
                var sepet = sepettekilerListesi[indeks];
                //Urun Fiyat Hesaplama
                urunFiyat = YemeklerDaoRepo().urunFiyatHesaplama(
                    fiyat: sepet.yemek_fiyat, adet: sepet.yemek_siparis_adet);
                //Burası 2 kez tetikleniyor o yüzden bu koşul şart!
                if (sepetIndex.contains(sepet.sepet_yemek_id) == false) {
                  if (yemekListe.contains(sepet.yemek_adi)) {
                    //Silinen Fiyatın Toplamdan Çıkartılması
                    toplamUrunFiyat -= urunFiyat;
                  }
                  sepetIndex.add(sepet.sepet_yemek_id);
                  //Fiyatın Toplanması
                  toplamUrunFiyat += urunFiyat;
                  context.read<SepetSayfaCubitIslem>().islem(toplamUrunFiyat);
                  //Aynı Siparişin Silinmesi
                  context.read<SepetSayfaCubit>().ayniSiparisSil(
                      sepet.sepet_yemek_id,
                      sepet.yemek_adi,
                      yemekListe,
                      widget.hesap);
                }

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        toplamUrunFiyat = 0;
                        yemekListe = [];
                        sepetIndex = [];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SepetYemekDetaySayfa(
                                    sepetYemekler: sepet,
                                    hesap: widget.hesap))).then((_) {
                          context
                              .read<SepetSayfaCubit>()
                              .sepetYukle(widget.hesap);
                        });
                      },
                      child: Card(
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color:
                                              TemelYapilarRenk().gorselArkaRenk,
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
                                              "http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}",
                                          fit: BoxFit.fill,
                                        )),
                                  )),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${sepet.yemek_adi}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: TemelYapilarRenk()
                                              .kategoriAdiRenk),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text("Birim Ücreti",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: TemelYapilarRenk()
                                                          .kategoriFiyatRenk)),
                                            ),
                                            Text("${sepet.yemek_fiyat} ₺",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: TemelYapilarRenk()
                                                        .kategoriFiyatRenk)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text("Sipariş Adedi",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: TemelYapilarRenk()
                                                          .kategoriFiyatRenk)),
                                            ),
                                            Text("${sepet.yemek_siparis_adet}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: TemelYapilarRenk()
                                                        .kategoriFiyatRenk)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Ürün Fiyatı: ",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "$urunFiyat ₺",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                    color: TemelYapilarRenk().kategoriCubukRenk,
                                    height: 120,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: TemelYapilarRenk()
                                                .kategoriIkonRenk,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "${sepet.yemek_adi} silinsin mi?"),
                                                action: SnackBarAction(
                                                  label: "Evet",
                                                  onPressed: () {
                                                    //Toplam Urun Fiyat Tetikleme
                                                    toplamUrunFiyat = 0;
                                                    yemekListe = [];
                                                    sepetIndex = [];
                                                    context
                                                        .read<
                                                            SepetSayfaCubitIslem>()
                                                        .islem(toplamUrunFiyat);
                                                    //Yemek Silme İşlemi
                                                    context
                                                        .read<SepetSayfaCubit>()
                                                        .yemekSil(
                                                            sepet
                                                                .sepet_yemek_id,
                                                            widget.hesap);
                                                  },
                                                ),
                                              ));
                                            },
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color: TemelYapilarRenk()
                                                  .kategoriIkonRenk,
                                            ),
                                          ),
                                        ])),
                              ),
                            ]),
                      ),
                    ),
                  ],
                );
              });
        } else {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Siparişiniz Bulunmamaktadır",
                style:
                    TextStyle(fontSize: 24, color: TemelYapilarRenk().anaRenk),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              YemekListeSayfa(hesap: widget.hesap)));
                },
                child: Text(
                  "Yemek Listesini Görüntülemek İçin Buraya Tıklayın.",
                  style: TextStyle(
                      fontSize: 16, color: TemelYapilarRenk().kategoriIkonRenk),
                ),
              )
            ]),
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Sipariş Ver",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (toplamUrunFiyat != 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Siparişiniz Başarıyla Alınmıştır",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Sipariş Girişi Yapılmamıştır.",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
      ),
    );
  }
}
