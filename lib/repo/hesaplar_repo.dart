import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';

class HesaplarDaoRepo {
  var refHesaplar =
      FirebaseDatabase.instance.reference().child("Kullanici-Kayit-Adres");

  Future<void> hesapKayit(String kullanici_adi, String adres, String ilce,
      String il, String tel) async {
    var bilgi = HashMap<String, dynamic>();
    bilgi["hesap_id"] = "";
    bilgi["kullanici_adi"] = kullanici_adi;
    bilgi["adres"] = adres;
    bilgi["ilce"] = ilce;
    bilgi["il"] = il;
    bilgi["tel"] = tel;
    refHesaplar.push().set(bilgi);
  }

  bool hesapAcikKontrol({required String hesap}) {
    if (hesap == "") {
      return false;
    } else {
      return true;
    }
  }
}
