import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swipe to dismiss Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListSwipeToDismiss(title: 'Flutter Demo Swipe to dismiss '),
    );
  }
}

class ListSwipeToDismiss extends StatefulWidget {
  const ListSwipeToDismiss({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ListSwipeToDismiss> createState() => _ListSwipeToDismissState();
}

class _ListSwipeToDismissState extends State<ListSwipeToDismiss> {
  final _items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final String item = _items[index];
            return Dismissible(
                key: Key(item),
                onDismissed: (DismissDirection dir) {
                  setState(() => _items.removeAt(index));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(dir == DismissDirection.startToEnd
                        ? '$item remoted'
                        : '$item liked.'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        setState(() => _items.insert(index, item));
                      },
                    ),
                  ));
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.delete),
                ),
                secondaryBackground: Container(
                  color: Colors.green,
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.thumb_up),
                ),
                child: ListTile(
                  title: Center(
                    child: Text(_items[index]),
                  ),
                ));
          }),
    );
  }
}
