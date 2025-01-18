import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListPage(),
    );
  }
}

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask() {
    setState(() {
      if (taskController.text.isNotEmpty) {
        tasks.add(taskController.text);
        taskController.clear();
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Digite uma tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              child: Text('Adicionar Tarefa'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
