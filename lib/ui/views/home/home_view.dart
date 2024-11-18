import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> _pictures = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {}

  addPicture() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
            backgroundColor: const Color(0xff03bf9b),
            title: const Text("Camscanner"),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var picture in _pictures) Image.file(File(picture)),
              ],
            ),
          )),
          floatingActionButton: Container(
            width: 320,
            height: 70,
            // margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: const BoxDecoration(borderRadius: BorderRadius.zero),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.white,
                  backgroundColor: const Color.fromARGB(211, 3, 191, 157),
                ),
                onPressed: () {
                  addPicture();
                },
                child: const Icon(Icons.add)),
          ),
        );
      },
    );
  }
}
