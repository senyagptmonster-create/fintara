import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fintara_store.dart';
import 'screens.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FintaraStore()),
      ],
      child: MaterialApp(
        title: 'Fintara',
        debugShowCheckedModeBanner: false,
        home: const FintaraHome(),
      ),
    );
  }
}
