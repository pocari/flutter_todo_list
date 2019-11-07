import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;
  Todo({@required this.title, @required this.description})
      : assert(title != null),
        assert(description != null);
}

void main() => runApp(
      MaterialApp(
        title: 'Navigation Sample By Todo List',
        home: TodoScreen(
          todos: List<Todo>.generate(
            20,
            (i) => Todo(
              title: 'TODO $i',
              description: 'TODO $i の詳細',
            ),
          ),
        ),
      ),
    );

class TodoScreen extends StatelessWidget {
  final List<Todo> _todos;

  TodoScreen({Key key, @required List<Todo> todos})
      : assert(todos != null),
        this._todos = todos,
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('TODO リスト'),
        ),
        body: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_todos[index].title),
            onTap: () async {
              print('go to detail screen');
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todo: _todos[index]),
                ),
              );
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("$result が押されました"),
                  ),
                );
            },
          ),
        ),
      );
}

class TodoDetailScreen extends StatelessWidget {
  final Todo _todo;

  TodoDetailScreen({Key key, @required Todo todo})
      : assert(todo != null),
        this._todo = todo,
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_todo.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(_todo.description),
              ),
              RaisedButton(
                child: Text("ボタン1"),
                onPressed: () {
                  print("ボタン1 pressed");
                  Navigator.pop(context, '${_todo.title}のボタン1');
                },
              ),
              RaisedButton(
                child: Text("ボタン2"),
                onPressed: () {
                  print("ボタン2 pressed");
                  Navigator.pop(context, '${_todo.title}のボタン2');
                },
              ),
            ],
          ),
        ),
      );
}
