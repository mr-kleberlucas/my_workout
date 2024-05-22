//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Providers
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _user = {'email': '', 'password': '', 'confirmPassword': ''};
  final _formKey = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  bool _loading = false;
  bool _login = true;
  late AnimationController _controller;
  late Animation<Size> _heigthAnimation;

  void _save() async {
    bool valid = _formKey.currentState!.validate();

    if (valid) {
      setState(() {
        _loading = true;
      });
      try {
        _formKey.currentState!.save();

        if (_login) {
          await Provider.of<AuthProvider>(context, listen: false).manageAuth(
            _user['email'],
            _user['password'],
            'signInWithPassword',
          );
        } else {
          if (_user['password'] == _user['confirmPassword']) {
            await Provider.of<AuthProvider>(context, listen: false).manageAuth(
              _user['email'],
              _user['password'],
              'signUp',
            );
            _formKey.currentState!.reset();
            _showAlert('Sucesso',
                'Usuário Cadastrado, você já pode entrar no sistema');
            // setState(() {
            //   _login = true;
            // });
            _switchMode();
          } else {
            _showAlert('Formulário Inválido', 'As senhas devem ser iguais');
          }
        }
      } catch (e) {
        // _showAlert('Não foi possível completar a operação', e.toString());
        _showAlert('Não foi possível completar a operação',
            e.toString().substring(11));
        // print(e);
      } finally {
        _loading = !_loading;
      }
      // print(_user);
    }
  }

  void _showAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style:
              TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
        ),
      ),
    );
  }

  void _switchMode() {
    if (_login) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    setState(() {
      _login = !_login;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    _heigthAnimation = Tween<Size>(
            begin: const Size(double.infinity, 200),
            end: const Size(double.infinity, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // _heigthAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                AnimatedBuilder(
                  animation: _heigthAnimation,
                  builder: (ctx, ch) {
                    return SizedBox(
                      height: _heigthAnimation.value.height,
                      child: ch,
                    );
                  },
                  child: const Text(
                    'MyWorkout',
                    style: TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_passwordFocus),
                  validator: (value) {
                    if (value!.length < 4) {
                      return 'Insira um email válido';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _user['email'] = newValue!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_confirmPasswordFocus),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'A senha deve conter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (newValue) => _user['password'] = newValue!,
                ),
                AnimatedContainer(
                  height: _login ? 0 : 100,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedOpacity(
                    opacity: _login ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Confirmar Senha'),
                      focusNode: _confirmPasswordFocus,
                      validator: (value) {
                        if (value!.length < 6 && !_login) {
                          return 'A senha deve conter no mínimo 6 caracteres';
                        }
                        return null;
                      },
                      obscureText: true,
                      onSaved: (newValue) =>
                          _user['confirmPassword'] = newValue!,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!_loading)
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                      child: Text(
                        _login ? 'ENTRAR' : 'CADASTRAR',
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                    ),
                  ),
                if (!_loading)
                  TextButton(
                    onPressed: _switchMode,
                    child: Text(
                      _login
                          ? 'Não tenho uma conta'
                          : 'Já possuo uma conta, entrar',
                      style: TextStyle(
                        color:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                    ),
                  ),
                if (_loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
