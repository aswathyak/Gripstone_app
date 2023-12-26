import 'package:flutter/material.dart';

import 'data_model.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.data,
    required this.edit,
    required this.index,
    required this.delete,
  }) : super(key: key);
  final DataModel data;
  final Function edit;
  final Function delete;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: IconButton(
              onPressed: () {
                edit(index);
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ),
        title: Text(
          data.title,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        subtitle: Text(
          data.subtitle,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        trailing: CircleAvatar(
            backgroundColor: Colors.red,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                delete(index);
              },
            )),
      ),
    );
  }
}
