import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yemekciyerim_bitirmepr/entity/sepet_yemekler.dart';
import 'package:yemekciyerim_bitirmepr/entity/sepet_yemekler_cevap.dart';
import 'package:yemekciyerim_bitirmepr/entity/yemekler.dart';
import 'package:yemekciyerim_bitirmepr/entity/yemekler_cevap.dart';

class YemeklerDaoRepo {
  List<Yemekler> parseYemeklerCevap(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemeklerListesi;
  }

  List<SepetYemekler> parseSepetYemeklerCevap(String cevap) {
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepetYemeklerListesi;
  }

  Future<List<Yemekler>> tumYemekleriAl() async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi,
      yemek_fiyat, yemek_siparis_adet, String kullanici_adi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat.toString(),
      "yemek_siparis_adet": yemek_siparis_adet.toString(),
      "kullanici_adi": kullanici_adi,
    };
    var cevap = await http.post(url, body: veri);
    print("eklenen yemek : ${cevap.body}");
  }

  Future<List<SepetYemekler>> sepettekiYemekleriAl(String kullanici_adi) async {
    var url = Uri.parse(
        "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await http.post(url, body: veri);
    try {
      return parseSepetYemeklerCevap(cevap.body);
    } catch (e) {
      return [];
    }
  }

  Future<void> sepetYemekSil(
      String sepet_yemek_id, String kullanici_adi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await http.post(url, body: veri);
    print("Yemek sil: ${cevap.body}");
  }

  int urunFiyatHesaplama({required String fiyat, required String adet}) {
    int intFiyat = int.parse(fiyat);
    int intAdet = int.parse(adet);
    int toplam = intFiyat * intAdet;
    return toplam;
  }

  Future<void> sepetGuncelle(
      String sepet_yemek_id,
      String yemek_adi,
      String yemek_resim_adi,
      yemek_fiyat,
      yemek_siparis_adet,
      String kullanici_adi) async {
    var silmeUrl =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var silinmeVeri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi
    };
    var silinmeCevap = await http.post(silmeUrl, body: silinmeVeri);
    print("Yemek sil: ${silinmeCevap.body}");
    //Ekleme İşlemi
    var ekleUrl =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var ekleVeri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat.toString(),
      "yemek_siparis_adet": yemek_siparis_adet.toString(),
      "kullanici_adi": kullanici_adi,
    };
    var ekleCevap = await http.post(ekleUrl, body: ekleVeri);
    print("eklenen yemek : ${ekleCevap.body}");
  }

  String ayniSiparisKontrol(
      String sepet_yemek_id, String yemek_adi, yemekListe) {
    if (yemekListe.contains(yemek_adi)) {
      var silinecek = sepet_yemek_id;
      print("Silinecek : ${silinecek}, $yemek_adi");
      return silinecek;
    } else {
      yemekListe.add(yemek_adi);
      return "";
    }
  }
}
