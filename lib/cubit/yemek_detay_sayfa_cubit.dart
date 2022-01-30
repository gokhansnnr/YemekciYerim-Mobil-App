import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/entity/yemekler.dart';
import 'package:yemekciyerim_bitirmepr/repo/yemeklerdao_repo.dart';

class YemekDetayCubit extends Cubit<void> {
  YemekDetayCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> ekle(String yemek_adi, String yemek_resim_adi, yemek_fiyat,
      yemek_siparis_adet, String kullanici_adi) async {
    await yrepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat,
        yemek_siparis_adet, kullanici_adi);
  }

  Future<void> guncelle(
      String sepet_yemek_id,
      String yemek_adi,
      String yemek_resim_adi,
      yemek_fiyat,
      yemek_siparis_adet,
      String kullanici_adi) async {
    await yrepo.sepetGuncelle(sepet_yemek_id, yemek_adi, yemek_resim_adi,
        yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}
