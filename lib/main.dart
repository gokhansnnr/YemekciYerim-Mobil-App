import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekciyerim_bitirmepr/cubit/hesap_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/cubit/sepet_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/cubit/yemek_detay_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/cubit/yemek_liste_sayfa_cubit.dart';
import 'package:yemekciyerim_bitirmepr/views/hesap_sorgu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => YemekListeCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
        BlocProvider(create: (context) => YemekDetayCubit()),
        BlocProvider(create: (context) => SepetSayfaCubitIslem()),
        BlocProvider(create: (context) => HesapSayfaCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HesapSorgu(),
      ),
    );
  }
}
