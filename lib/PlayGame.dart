import 'dart:async';

import 'package:flutter/material.dart';

String _log = '______\n\n';

class PlayGame extends StatefulWidget {
  PlayGame({Key key}) : super(key: key);

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  List<List> _matrix;
  String _playerWinner = '';
  bool _endGame = false;

  // List<String> _logAll =

  int _counter = 3;
  _PlayGames(int i) {
    _matrix = List<List>(i);
    for (var row = 0; row < _matrix.length; row++) {
      _matrix[row] = List(i);
      for (var col = 0; col < _matrix[row].length; col++) {
        _matrix[row][col] = '-';
      }
    }
    _playerWinner = '';
    _endGame = false;
  }

  void _plusCounter() {
    setState(() {
      _counter++;
      _PlayGames(_counter);
    });
  }

  void _minusCounter() {
    setState(() {
      if (_counter > 3) {
        _counter--;
      }

      _PlayGames(_counter);
    });
  }

  void _restertgame() {
    setState(() {
      _counter = 3;
      _PlayGames(_counter);
    });
  }

  @override
  void initState() {
    super.initState();
    _PlayGames(_counter);
  }

  @override
  Widget build(BuildContext context) {
    // print(_counter);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                _player == 'O' ? 'Player : X' : 'Player : O',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: List.generate(
                  _counter,
                  (row) => Row(
                    children:
                        List.generate(_counter, (col) => _table(row, col)),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _playerWinner == '' ? '' : '$_playerWinner won',
                style: TextStyle(fontSize: 30),
              ),
              RaisedButton(
                  color: Colors.green[50],
                  onPressed: () {
                    setState(() {
                      _PlayGames(_counter);
                    });
                  },
                  child: Text('Restart')),
              Text('\n$_log'),
              // Text(_playerWinner == '' ? '' : '$_playerWinner won')
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                  disabledColor: Colors.transparent,
                  elevation: 0.0,
                  color: Colors.transparent,
                  onPressed: _restertgame,
                  child: Icon(
                    Icons.refresh,
                  )),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 40,
                child: RaisedButton(
                  disabledColor: Colors.transparent,
                  elevation: 0.0,
                  color: Colors.transparent,
                  onPressed: _minusCounter,
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              Text(
                '$_counter',
                // style: TextStyle(color: Colors.white),
              ),
              Container(
                width: 40,
                child: RaisedButton(
                  disabledColor: Colors.transparent,
                  elevation: 0.0,
                  color: Colors.transparent,
                  onPressed: _plusCounter,
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _player = 'O';
  _table(int row, int col) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black),
        ),
        child: FlatButton(
          clipBehavior: Clip.antiAlias,
          onPressed:
              //เมื่อมีผู้ชนะแล้วไม่ให้กดได้อีก
              _endGame == true
                  ? null
                  : () {
                      _changPlayer(row, col);
                      _checkWinner(row, col);

                      for (var q = 0; q < _matrix.length; q++) {
                        for (var a = 0; a < _matrix[q].length; a++) {
                          _log = _log + " " + _matrix[q][a];
                        }
                        _log += '\n';
                      }
                      _log += '______\n\n';
                      _log += _playerWinner == ''
                          ? ''
                          : '$_playerWinner won\n______\n\n';
                      // print(_log);

                      // print('__________________');
                    },
          child: Column(
            children: [
              Text(
                _matrix[row][col] == '-' ? '' : _matrix[row][col],
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //สลับผู้เล่นระหว่าง X กับ O
  _changPlayer(int row, int col) {
    setState(() {
      if (_matrix[row][col] == '-') {
        if (_player == 'O') {
          _matrix[row][col] = 'X';
        } else {
          _matrix[row][col] = 'O';
        }
        _player = _matrix[row][col];
      }
    });
  }

  //เช็คผลชนะ
  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rding = 0;
    var n = _matrix.length - 1;
    var playerWinner = _matrix[x][y];

    for (var i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == playerWinner) {
        col++;
      }
      if (_matrix[i][y] == playerWinner) {
        row++;
      }
      if (_matrix[i][i] == playerWinner) {
        diag++;
      }
      if (_matrix[i][n - i] == playerWinner) {
        rding++;
      }
    }
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rding == n + 1) {
      //จบเกม
      _endGame = true;

      //เก็บตัวแปรผู้ชนะไปแสดงผล
      setState(() {
        _playerWinner = playerWinner;
      });
    }
  }
}
