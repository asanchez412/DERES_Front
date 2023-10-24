import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topicos/admin/bloc/admin_state.dart';
import 'package:topicos/home/view/home_page.dart';

class AdminPollPage extends Page<void> {
  const AdminPollPage({
    super.key,
    //required this.bloc
  });

  static const path = '/admin-poll';
  //final CompanyBloc bloc;

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      settings: this,
      builder: (context) {
        return const AdminPollView();
        // BlocProvider.value(
        //   value: bloc,
        //   child: const CompanyPollView(),
        // );
      },
    );
  }
}

class AdminPollView extends StatelessWidget {
  const AdminPollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            context.go(HomePage.path);
          },
          child: Row(
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
                'Encuesta',
              ),
            ],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.orangeAccent,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _EditQuestions(),
            SizedBox(height: 40),
            _Environmental(),
            _Social(),
            _Governance(),
            _ButtonSend(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ButtonSend extends StatelessWidget {
  const _ButtonSend();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => (),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orangeAccent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: const Text('Editar Evaluacion'),
    );
  }
}

class _Governance extends StatelessWidget {
  const _Governance();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 30, bottom: 20),
          child: Text(
            'Evaluación Gobernanza',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        _Checkbox(
          question:
              '¿Tiene un código de conducta ética que deben seguir todos los empleados y directivos?',
          onChanged: () {},
        ),
        _Checkbox(
          question:
              '¿Publica informes financieros de manera regular y transparente?',
          onChanged: () {},
        ),
        _Checkbox(
          question:
              '¿Tiene políticas y medidas en vigor para prevenir la corrupción y el soborno?',
          onChanged: () {},
        ),
        _Checkbox(
          question:
              '¿Desarrolla proyectos o iniciativas de responsabilidad social corporativa?',
          onChanged: () {},
        ),
        _Checkbox(
          question: '¿Realiza su logística en vehículos eléctricos?',
          onChanged: () {},
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _Social extends StatelessWidget {
  const _Social();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 30, bottom: 20),
          child: Text(
            'Evaluación Social',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        _Checkbox(
          question: '¿Tiene políticas de diversidad e inclusión?',
          onChanged: () {},
        ),
        _Checkbox(
          question:
              '¿Ofrece programas de salud y bienestar para sus empleados?',
          onChanged: () {},
        ),
        _Checkbox(
          question:
              '¿Proporciona oportunidades regulares de formación y desarrollo para sus empleados?',
          onChanged: () {},
        ),
        _Checkbox(
          question:
              '¿Se compromete a pagar salarios justos y equitativos a sus empleados?',
          onChanged: () {},
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText:
                  '¿Cuántos funcionarios transgénero tiene en su plantilla?',
            ),
            onChanged: (value) => (),
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

class _Environmental extends StatelessWidget {
  const _Environmental();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 30, bottom: 20),
          child: Text(
            'Evaluación Ambiental',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        _Checkbox(
          question: '¿Recicla en su proceso productivo?',
          onChanged: () {},
        ),
        _Checkbox(
          question: '¿Realiza su logística en vehículos eléctricos?',
          onChanged: () {},
        ),
        _Checkbox(
          question: '¿Utiliza fuentes de energía renovable en su operación?',
          onChanged: () {},
        ),
        _Checkbox(
          question: '¿Tiene un programa para reducir y gestionar residuos?',
          onChanged: () {},
        ),
        _Checkbox(
          question:
              '¿Implementa prácticas de conservación de agua en sus operaciones?',
          onChanged: () {},
        ),
      ],
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({
    required this.question,
    required this.onChanged,
  });

  final String question;
  final VoidCallback onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(question),
        ),
        SizedBox(
          width: 130,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ponderación',
            ),
            onChanged: (value) => (),
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

class _EditQuestions extends StatelessWidget {
  const _EditQuestions();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 30, bottom: 20),
            child: Text(
              'Agregar Preguntas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Nueva Pregunta'),
                    onChanged: (value) => (),
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obligatorio' : null,
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: DropdownButton<QuestionType>(
                  value: QuestionType.environmental,
                  items: QuestionType.values.map((value) {
                    return DropdownMenuItem<QuestionType>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(value.name),
                      ), // Usando la extensión para obtener el nombre del enum
                    );
                  }).toList(),
                  onChanged: (QuestionType? newValue) {},
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
