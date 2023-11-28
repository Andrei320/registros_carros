import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:registros_carros/bloc/carros_bloc/carros_bloc.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_event.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_state.dart';
import 'package:registros_carros/database_helper/carros_database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final carrosDatabase = DBCarro();
  await carrosDatabase.initializeDatabase();
  runApp(
    BlocProvider(
      create: (context) => CarroBloc(carrosDatabase),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MainApp()),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CarroBloc>(context).add(Inicializado());
    BlocProvider.of<CarroBloc>(context).add(GetCarros());
  }

  int _indiceSeleccionado = 0;

  final List<Widget> _paginas = [
    const ListaCarros(),
    const ListaCategorias(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Control de Gastos Vehicular')),
        backgroundColor: Colors.indigoAccent,
        actions: const [],
      ),
      body: _paginas[_indiceSeleccionado],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash_outlined),
            label: 'Carros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
        ],
        currentIndex: _indiceSeleccionado,
        onTap: _onTabTapped,
        backgroundColor: Colors.indigoAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
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
  const ListaCarros({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CarroBloc, CarroEstado>(
        builder: (context, state) {
          if (state is GetAllCarros) {
            return _listaCarros(state.carros);
          } else if (state is ErrorGetAllCarros) {
            return Center(child: Text('Error: ${state.mensajeError}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarModal(context, 'Nuevo Carro');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _listaCarros(List<Map<String, dynamic>>? carros) {
    if (carros != null && carros.isNotEmpty) {
      return ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          final carro = carros[index];
          int carroID = carros[index]['idcarro'];
          int archivado = carros[index]['archivado'];
          return Column(
            children: [
              ListTile(
                title: Text(carro['apodo'] ?? 'No Apodo'),
                subtitle: const Text('Pendiente'),
                tileColor: archivado == 1 ? Colors.white : Colors.red,
              ),
              // Agregar el botón de borrado aquí
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Center(child: Text('¿Eliminar Carro?')),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CarroBloc>()
                                      .add(EliminarCarro(idCarro: carroID));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Eliminar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Borrar'),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ElevatedButton.icon(
                    onPressed: () {
                      _mostrarModalEditar(context,
                          carro); // Envía los datos del carro para la edición
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                                child: archivado == 1
                                    ? const Text('¿Archivar Carro?')
                                    : const Text('¿Volver a activar?')),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CarroBloc>()
                                      .add(ArchivarCarro(idcarro: carroID));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Archivar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.archive),
                    label: const Text('Archivar'),
                  ),
                ],
              ),
              const Divider(), // Separador entre elementos de la lista
            ],
          );
        },
      );
    } else {
      return const Center(child: Text('No hay carros disponibles'));
    }
  }

  void _mostrarModal(BuildContext context, String carros) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const FractionallySizedBox(
          heightFactor: 1.2,
          child: AgregarCarro(),
        );
      },
    );
  }
}

class AgregarCarro extends StatefulWidget {
  const AgregarCarro({super.key});

  @override
  State<AgregarCarro> createState() => _AgregarCarroState();
}

class _AgregarCarroState extends State<AgregarCarro> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController apodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarroBloc, CarroEstado>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Nuevo Carro'),
            backgroundColor: Colors.purple,
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
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        _insertarCarro(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text('Insertar Carro'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _insertarCarro(BuildContext context) {
    final miBloc = BlocProvider.of<CarroBloc>(context);

    if (_formKey.currentState?.validate() ?? false) {
      miBloc.add(
        InsertarCarro(
          apodo: apodoController.text,
        ),
      );
    }
  }
}

// Agrega un nuevo método para mostrar el modal de edición
void _mostrarModalEditar(BuildContext context, Map<String, dynamic> carro) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 1.2,
        child: EditarCarro(carro: carro),
      );
    },
  );
}

// Crea un nuevo widget para la edición del carro
class EditarCarro extends StatefulWidget {
  final Map<String, dynamic> carro;

  const EditarCarro({super.key, required this.carro});

  @override
  State<EditarCarro> createState() => _EditarCarroState();
}

class _EditarCarroState extends State<EditarCarro> {
  late TextEditingController apodoController;

  @override
  void initState() {
    super.initState();
    apodoController = TextEditingController(text: widget.carro['apodo']);
    // Agrega inicializaciones de otros campos si es necesario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Carro'),
        backgroundColor: Colors.blueAccent, // Color para identificar la edición
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  _actualizarCarro(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Actualizar Carro'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _actualizarCarro(BuildContext context) {
    final miBloc = BlocProvider.of<CarroBloc>(context);

    if (apodoController.text.isNotEmpty) {
      miBloc.add(
        UpdateCarro(
          apodo: apodoController.text,
          idcarro: widget.carro['idcarro'],
        ),
      );
      Navigator.of(context)
          .pop(); // Cierra el modal después de la actualización
    }
  }
}

class ListaCategorias extends StatelessWidget {
  const ListaCategorias({super.key});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
