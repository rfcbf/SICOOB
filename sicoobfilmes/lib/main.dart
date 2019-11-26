import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sicobfilmes/components/alert_widget.dart';
import 'package:sicobfilmes/model/cores.dart';
import 'package:sicobfilmes/screen/dashboard.dart';
import 'package:sicobfilmes/service/connectionStatus.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  StatusConexao _conexao = StatusConexao.getInstance();
  _conexao.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StatusConexao _conexao = StatusConexao.getInstance();

  BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();
    _conexao.connectionChange.listen(connectionChanged);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _conexao.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void connectionChanged(dynamic hasConnection) {
    if (hasConnection) {
      _conexao.count = 0;
      _conexao.hasConnection = true;
    } else {
      _conexao.count = 0;
      _conexao.hasConnection = false;
    }

    if (_conexao.primeiraVez) {
      _conexao.primeiraVez = false;
      _conexao.count++;
    } else {
      if (_conexao.count == 0) {
        setState(() {});
        if (_conexao.hasConnection) {
          _conexao.count++;

          AlertaComConexao(context: _scaffoldContext).exibir();
        } else {
          _conexao.count++;
          AlertaSemConexao(context: _scaffoldContext).exibir();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.brown,
        hintColor: Colors.white,
        errorColor: Colors.white,
      ),
      home: splashScreen(context),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => Dashboard(),
      },
    );
  }

  splashScreen(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Builder(builder: (BuildContext context) {
        _scaffoldContext = context;
        return Dashboard();
      }),
      title: new Text(
        'SICOOB Filmes',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Cores.branco),
      ),
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Cores.diesel,
          Cores.diesel,
        ],
      ),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Cores.branco,
      loadingText: Text(
        'Carregando...',
        style: TextStyle(color: Cores.branco),
      ),
    );
  }
}
