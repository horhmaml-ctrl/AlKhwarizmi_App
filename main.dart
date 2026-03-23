import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlKhwarizmiHome(),
    ));

class AlKhwarizmiHome extends StatefulWidget {
  const AlKhwarizmiHome({super.key});

  @override
  State<AlKhwarizmiHome> createState() => _AlKhwarizmiHomeState();
}

class _AlKhwarizmiHomeState extends State<AlKhwarizmiHome> {
  List<Map<String, String>> entries = [];

  void _addEntry(String note, String amount) {
    if (note.isNotEmpty && amount.isNotEmpty) {
      setState(() {
        entries.add({
          "note": note,
          "amount": amount,
          "date": DateTime.now().toString().substring(0, 10)
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الخوارزمي المحاسبي"),
        backgroundColor: Colors.indigo[900],
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.indigo[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("إجمالي القيود:", style: TextStyle(color: Colors.white)),
                  Text("${entries.length}", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(entries[index]['note']!),
                    subtitle: Text(entries[index]['date']!),
                    trailing: Text("${entries[index]['amount']} ريال", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        backgroundColor: Colors.indigo[900],
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    String note = "";
    String amount = "";
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("إضافة عملية"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: "البيان"), onChanged: (v) => note = v),
            TextField(decoration: const InputDecoration(labelText: "المبلغ"), keyboardType: TextInputType.number, onChanged: (v) => amount = v),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _addEntry(note, amount);
              Navigator.of(ctx).pop();
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );
  }
}
