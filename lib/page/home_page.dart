import 'package:flutter/material.dart';
import '../helper/db_helper.dart';
import '../model/database_model.dart';
import '../page/home_dialog.dart';

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
        title: const Text('Latihan SQLite'),
      ),
      body: FutureBuilder<List<DatabaseModel>>(
        future: DbHelper.readData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('${snapshot.data[index].fullname}'),
                onTap: () => _showDialog(snapshot.data![index]),
              );
            },
          );
        },
        initialData: const <DatabaseModel>[],
      ),
      floatingActionButton:
          ElevatedButton(onPressed: _showDialog, child: Text('Tambah Data')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _showDialog([DatabaseModel? dbModel]) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => HomeDialog(
        dbModel: dbModel,
      ),
    );
    setState(() {});
  }
}
