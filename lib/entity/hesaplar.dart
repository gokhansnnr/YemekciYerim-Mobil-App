class Hesaplar {
  String hesap_id;
  String kullanici_adi;
  String acikAdres;
  String ilce;
  String il;
  String tel;

  Hesaplar(
      {required this.hesap_id,
      required this.kullanici_adi,
      required this.acikAdres,
      required this.ilce,
      required this.il,
      required this.tel});

  factory Hesaplar.fromJson(String key, Map<dynamic, dynamic> json) {
    return Hesaplar(
        hesap_id: key,
        kullanici_adi: json["kullanici_adi"] as String,
        acikAdres: json["acikAdres"] as String,
        ilce: json["ilce"] as String,
        il: json["il"] as String,
        tel: json["tel"] as String);
  }
}
