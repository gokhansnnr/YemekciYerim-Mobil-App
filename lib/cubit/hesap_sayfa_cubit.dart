import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/repo/hesaplar_repo.dart';

class HesapSayfaCubit extends Cubit<void> {
  HesapSayfaCubit() : super(0);

  var hrepo = HesaplarDaoRepo();
  var refHesaplar =
      FirebaseDatabase.instance.reference().child("Kullanici-Kayit-Adres");

  Future<void> kayit(String kullanici_adi, String adres, String ilce, String il,
      String tel) async {
    await hrepo.hesapKayit(kullanici_adi, adres, ilce, il, tel);
  }
}
