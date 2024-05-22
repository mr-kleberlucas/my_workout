//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Models
import '../models/workout.dart';

//* Providers
import '../providers/workout_provider.dart';

class WorkoutManagementScreen extends StatefulWidget {
  static const String route = '/workout-management';

  @override
  State<WorkoutManagementScreen> createState() =>
      _WorkoutManagementScreenState();
}

class _WorkoutManagementScreenState extends State<WorkoutManagementScreen> {
  Workout _workout = Workout();

  final _imageFocus = FocusNode();
  final _dropDownFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  // final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  bool _dropDownValid = true;
  // late int _dropDownValue;
  dynamic _dropDownValue;
  bool isInit = true;

  final List<Map<String, dynamic>> _dropDownOptions = [
    {'id': 1, 'name': 'Segunda-Feira'},
    {'id': 2, 'name': 'Terça-Feira'},
    {'id': 3, 'name': 'Quarta-Feira'},
    {'id': 4, 'name': 'Quinta-Feira'},
    {'id': 5, 'name': 'Sexta-Feira'},
    {'id': 6, 'name': 'Sábado'},
    {'id': 7, 'name': 'Domingo'},
  ];

  void _save(ctx) async {
    try {
      if (_dropDownValue != null && _dropDownValue > 0) {
        setState(() {
          _dropDownValid = true;
        });
      } else {
        setState(() {
          _dropDownValid = false;
        });
      }
      bool valid = _form.currentState!.validate();
      if (valid && _dropDownValid) {
        _form.currentState!.save();
        _workout.weekDay = _dropDownValue;

        if (_workout.id != null) {
          await Provider.of<WorkoutProvider>(context, listen: false)
              .update(_workout);
        } else {
          await Provider.of<WorkoutProvider>(context, listen: false)
              .add(_workout);
        }
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('$e'),
          // content: Text('Erro!'),
        ),
      );

      // _scaffoldKey.currentState?.showSnackBar(
      //   SnackBar(
      //     content: Text('$e'),
      //   ),
      // );
    }
  }

  void _delete() async {
    Navigator.of(context).pop();
    await Provider.of<WorkoutProvider>(context, listen: false)
        .delete(_workout.id);
    Navigator.of(context).pop();
  }

  void _showConfirmationModal() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Você tem certeza?'),
        content: const Text('Esta ação não poderá ser desfeita!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: _delete,
            child: const Text('Sim, continuar'),
          ),
        ],
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   print(ModalRoute.of(context)!.settings.arguments);
  //   print('init state');
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isInit) {
      final dynamic arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments['id'] != null) {
        _workout = Provider.of<WorkoutProvider>(context, listen: false)
            .getById(arguments['id']);
        _dropDownValue = _workout.weekDay;
      }
    }
    isInit = false;
  }

  // @override
  // void didUpdateWidget(covariant WorkoutManagementScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   print('did update');
  // }

  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  //   print('deactivate');
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   print('dispose');
  // }

  @override
  Widget build(BuildContext context) {
    print('build');

    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    print(arguments);

    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text(arguments['title']),
        actions: _workout.id != null
            ? [
                IconButton(
                  onPressed: _showConfirmationModal,
                  icon: const Icon(Icons.delete),
                ),
              ]
            : [],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: _workout.name,
                    onSaved: (newValue) => _workout.name = newValue!,
                    //* Alterando botão do keyboard para ser "next" e não "done"
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_imageFocus),
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return 'O nome deve conter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _workout.imageUrl,
                    onSaved: (newValue) => _workout.imageUrl = newValue!,
                    focusNode: _imageFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_dropDownFocus),
                    decoration: const InputDecoration(labelText: 'Imagem URL'),
                    validator: (value) {
                      if (!value!.startsWith('http://') &&
                          !value.startsWith('https://')) {
                        return 'Endereço de imagem inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 0.5,
                  ),
                  DropdownButtonHideUnderline(
                    child: Container(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      padding: const EdgeInsets.all(15),
                      child: DropdownButton(
                        value: _dropDownValue,
                        focusNode: _dropDownFocus,
                        items: _dropDownOptions
                            .map(
                              (e) => DropdownMenuItem(
                                value: e['id'],
                                child: Text(e['name']),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _dropDownValue = value;
                          });
                        },
                        hint: Text(
                          'Dia da Semana',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.subtitle2!.color,
                          ),
                        ),
                        icon: const Icon(Icons.calendar_today),
                        //* Expande o texto e joga o Ícone para o final
                        isExpanded: true,
                        iconEnabledColor:
                            Theme.of(context).colorScheme.secondary,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.subtitle1!.fontSize,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                        dropdownColor: const Color.fromRGBO(48, 56, 62, 0.9),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _dropDownValid ? '' : 'Selecione um dia da semana',
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 0.5,
                  ),
                  SizedBox(
                    height: 50,
                    child: Builder(
                      builder: (ctx) {
                        return ElevatedButton(
                          onPressed: () => _save(ctx),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .primary,
                          ),
                          child: Text(
                            'Salvar',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
