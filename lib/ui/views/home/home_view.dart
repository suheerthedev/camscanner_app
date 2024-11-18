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
    try {
      List<String>? pictures = await CunningDocumentScanner.getPictures();
      if (pictures != null) {
        setState(() {
          _pictures.addAll(pictures);
        });
      }
    } catch (exception) {
      print('Error adding pictures: $exception');
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
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
            backgroundColor: const Color(0xff03bf9b),
            title: const Text("Camscanner"),
          ),
          body: SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _pictures.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(_pictures[index]),
                      width: MediaQuery.of(context).size.width * 0.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: Container(
            width: 328,
            height: 70,
            margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
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
