import 'package:flutter/material.dart';
import 'package:flutter_base_project/pages/accueil.dart';
import 'package:uno/uno.dart';
// import 'package:flutter_base_project/pages/accueil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginUrl = 'http://192.168.123.173:5000/api/users/signin';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final uno = Uno();
  final _loginFormKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      // try {
      //   final response = await uno.post(loginUrl, data: {
      //     'email': emailController.text,
      //     'password': passwordController.text,
      //   });
      //   if (response.status == 200) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Connexion réussie')),
      //     );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Erreur de connexion')),
      //     );
      //   }
      // } catch (error) {
      //   print(error);
      // }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Non valide')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.login;
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
        // titleTextStyle: const TextStyle(
        //   fontSize: 24,
        //   fontFamily: 'Titillium Web',
        //   color: Colors.black,
        // ),
        elevation: 1,
      ),
      body: Center(
        child: Form(
          key: _loginFormKey,
          child: Card(
            elevation: 1,
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 60, 40, 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: emailController,
                      autofocus: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle),
                        hintText: 'example@email.com',
                        labelText: 'Login',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez insérer votre mail';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Adresse email invalide';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mot de passe requis';
                        } else if (value.length > 25) {
                          return 'Mot de passe trop long';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(icon),
                      label: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('Se connecter'),
                      ),
                      onPressed: () {
                        loginUser();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
