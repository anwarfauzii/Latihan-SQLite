import 'package:flutter/material.dart';

import '../../database/db_helper.dart';
import '../../model/note.dart';
import 'home_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: FutureBuilder<List<Note>>(
        future: DbHelper.readData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Note>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data![index].content),
                subtitle: Text('${snapshot.data![index].id}'),
                onTap: () => _showDialog(snapshot.data![index]),
              );
            },
            itemCount: snapshot.data!.length,
          );
        },
        initialData: const <Note>[],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDialog([Note? note]) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => HomeDialog(
        note: note,
      ),
    );
    setState(() {});
  }
}
