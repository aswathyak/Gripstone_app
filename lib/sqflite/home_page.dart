import 'package:flutter/material.dart';
import 'package:offline_app/sqflite/data_card.dart';

import 'data_model.dart';
import 'database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  List<DataModel> datas = [];
  bool fetching = true;
  int currentIndex = 0;
  late DB db;
  @override
  void initState() {
    db = DB();
    super.initState();
    getData2();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "SqFilte",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: datas.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: DataCard(
                    data: datas[index],
                    edit: edit,
                    index: index,
                    delete: delete,
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMyDilogue();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showMyDilogue() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(14),
            content: Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "title",
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: subtitleController,
                    decoration: const InputDecoration(
                      labelText: "Subtitle",
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  DataModel dataLocal = DataModel(
                      title: titleController.text,
                      subtitle: subtitleController.text);
                  db.insertData(dataLocal);
                  dataLocal.id = datas[datas.length - 1].id! + 1;
                  setState(() {
                    datas.add(dataLocal);
                  });
                  titleController.clear();
                  subtitleController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ),
            ],
          );
        });
  }

  void showMyDilogueUpdate() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(14),
            content: Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "title",
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: subtitleController,
                    decoration: const InputDecoration(
                      labelText: "Subtitle",
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  DataModel newData = datas[currentIndex];
                  newData.subtitle = subtitleController.text;
                  newData.title = titleController.text;
                  db.update(newData, newData.id!);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text(
                  "Update",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ),
            ],
          );
        });
  }

  void edit(index) {
    currentIndex = index;
    titleController.text = datas[index].title;
    subtitleController.text = datas[index].subtitle;

    showMyDilogueUpdate();
  }

  void delete(int index) {
    db.delete(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
  }
}
