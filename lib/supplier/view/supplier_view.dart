import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos/supplier/bloc/supplier_bloc.dart';

class SupplierView extends StatelessWidget {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                image: const DecorationImage(
                    image: AssetImage('lib/assets/deres.png'),
                    fit: BoxFit.cover,
                    scale: 2),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Proveedores',
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Busqueda de Proveedores'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              decoration:
                                  const InputDecoration(labelText: 'Nombre'),
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: TextField(
                              decoration:
                                  const InputDecoration(labelText: 'RUT'),
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: TextField(
                              decoration: const InputDecoration(
                                  labelText: 'Score (1-10)'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(width: 24),
                          OutlinedButton(
                            onPressed: () => (),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.orangeAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            child: const Text('Aplicar filtros'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const _ListSuppliers(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListSuppliers extends StatelessWidget {
  const _ListSuppliers();

  @override
  Widget build(BuildContext context) {
    final suppliers =
        context.select((SupplierBloc bloc) => bloc.state.suppliers);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nombre", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Tipo", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Score", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                final supplier = suppliers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(supplier.name),
                    subtitle: Text('Tipo: ${supplier.type}'),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Text(supplier.score.toString()),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
