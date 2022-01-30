import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/entity/sepet_yemekler.dart';
import 'package:yemekciyerim_bitirmepr/repo/yemeklerdao_repo.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit() : super(<SepetYemekler>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> sepetYukle(String kullanici_adi) async {
    var liste = await yrepo.sepettekiYemekleriAl(kullanici_adi);
    emit(liste);
  }

  Future yemekSil(String sepet_yemek_id, String kullanici_adi) async {
    await yrepo.sepetYemekSil(sepet_yemek_id, kullanici_adi);
    await sepetYukle(kullanici_adi);
  }

  Future<void> ayniSiparisSil(String sepet_yemek_id, String yemek_adi,
      yemekListe, String kullanici_adi) async {
    String sonuc =
        yrepo.ayniSiparisKontrol(sepet_yemek_id, yemek_adi, yemekListe);
    if (sonuc == "") {
      print("Silme yapılmadı.");
    } else {
      print("Aynı Olan Ürün Id: $sonuc");
      await yemekSil(sonuc, kullanici_adi);
      await sepetYukle(kullanici_adi);
    }
  }
}

class SepetSayfaCubitIslem extends Cubit<int> {
  SepetSayfaCubitIslem() : super(0);

  void islem(islem) {
    emit(islem);
  }
}
