import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:registros_carros/bloc/carros_bloc/carros_bloc.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_event.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_state.dart';
import 'package:registros_carros/database_helper/carros_database_helper.dart';

void main() async {
  await DBCarro.initializeDatabase();
  runApp(
    BlocProvider(
      create: (context) => CarroBloc(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CarroBloc(),
        child: const Scaffold(body: MainApp()),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _indiceSeleccionado = 0;

  final List<Widget> _paginas = [
    const ListaCarros(),
    const ListaMovimientos(),
    const ListaCategorias(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos Vehiculares'),
        backgroundColor: Colors.purple[200],
      ),
      body: _paginas[_indiceSeleccionado],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash_outlined),
            label: 'Carros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Movimientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
        ],
        currentIndex: _indiceSeleccionado,
        onTap: _onTabTapped,
        backgroundColor: Colors.purple[200],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
  }
}

class ListaCarros extends StatelessWidget {
  const ListaCarros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CarroBloc, CarroEstado>(
        builder: (context, state) {
          if (state is CarroSeleccionadoEstado) {
            // Puedes hacer algo específico cuando un carro está seleccionado
          }

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: DBCarro.getCarros(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> carros = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: carros.length,
                  itemBuilder: (context, index) {
                    int carroID = carros[index]['idcarro'];
                    String carroApodo = carros[index]['apodo'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(carroApodo),
                          onTap: () {
                            context.read<CarroBloc>().add(
                                CarroSeleccionado(indiceSeleccionado: carroID));
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text('¿Eliminar Carro?')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<CarroBloc>().add(
                                              EliminarCarro(idCarro: carroID));
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const AnadirCarro();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ListaMovimientos extends StatelessWidget {
  const ListaMovimientos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Movimientos'),
      ),
    );
  }
}

class ListaCategorias extends StatelessWidget {
  const ListaCategorias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Categorias'),
      ),
    );
  }
}

class AnadirCarro extends StatefulWidget {
  const AnadirCarro({Key? key}) : super(key: key);

  @override
  State<AnadirCarro> createState() => _AnadirCarroState();
}

class _AnadirCarroState extends State<AnadirCarro> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController apodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: apodoController,
                  decoration: InputDecoration(
                    labelText: 'Apodo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un apodo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String apodo = apodoController.text;

                      context.read<CarroBloc>().add(
                            InsertarCarro(
                              apodo: apodo,
                            ),
                          );

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Agregar Carro'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
