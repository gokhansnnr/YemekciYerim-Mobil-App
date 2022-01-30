import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/entity/yemekler.dart';
import 'package:yemekciyerim_bitirmepr/repo/yemeklerdao_repo.dart';

class YemekListeCubit extends Cubit<List<Yemekler>> {
  YemekListeCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> yemekleriYukle() async {
    var liste = await yrepo.tumYemekleriAl();
    emit(liste);
  }
}
