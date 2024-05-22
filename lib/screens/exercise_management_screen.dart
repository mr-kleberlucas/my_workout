//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Models
import '../models/exercise.dart';

//* Providers
import '../providers/exercise_provider.dart';

class ExerciseManagementScreen extends StatefulWidget {
  static const String route = '/exercise-management';

  @override
  State<ExerciseManagementScreen> createState() =>
      _ExerciseManagementScreenState();
}

class _ExerciseManagementScreenState extends State<ExerciseManagementScreen> {
  Exercise _exercise = Exercise();
  final _imageFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _form = GlobalKey<FormState>();

  bool isInit = true;

  void _save() async {
    try {
      bool valid = _form.currentState!.validate();
      if (valid) {
        _form.currentState!.save();

        await Provider.of<ExerciseProvider>(context, listen: false)
            .add(_exercise);
        Navigator.of(context).pop();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Falha ao salvar exercício'),
          content: Text('$e'),
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      // final Map<String, Object> arguments =
      // ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      final dynamic arguments = ModalRoute.of(context)?.settings.arguments;
      _exercise.workoutId = arguments['workoutId'];
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar novo Exercício'),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg4.jpg'),
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
                    onSaved: (newValue) => _exercise.name = newValue,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'O nome deve conter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_imageFocus),
                  ),
                  TextFormField(
                    onSaved: (newValue) => _exercise.imageUrl = newValue,
                    focusNode: _imageFocus,
                    decoration: const InputDecoration(labelText: 'Imagem URL'),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (!value!.startsWith('http://') &&
                          !value.startsWith('https://')) {
                        return 'Informe um endereço de imagem válido';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_descriptionFocus),
                  ),
                  TextFormField(
                    onSaved: (newValue) => _exercise.description = newValue,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    focusNode: _descriptionFocus,
                    maxLength: 200,
                    minLines: 3,
                    maxLines: 5,
                    //* Contador de caracteres no campo
                    buildCounter: (_,
                            {required currentLength,
                            required isFocused,
                            maxLength}) =>
                        Text(
                      '$currentLength/$maxLength',
                      style: const TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.length < 5) {
                        return 'A descrição deve conter pelo menos 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 0.5,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                      ),
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
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
