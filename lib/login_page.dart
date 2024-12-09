import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toggleVisiblePassword() => setState(() => showPassword = !showPassword);

  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    if (email?.isEmpty ?? true) return "メールアドレスを入力してください";

    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (email != null && !regex.hasMatch(email)) return "有効なメールアドレスを入力してください";

    return null;
  }

  void _login(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid == false) return;

    print(_emailController.text);
    print(_passwordController.text);

    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await auth.setPersistence(
        _keepLoggedIn ? Persistence.LOCAL : Persistence.SESSION,
      );

      context.go("/");
    } on FirebaseException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ログインに失敗しました${err.code}')),
      );
    }
  }

  bool _keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go("/"),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: Text(
                      "Memoにログイン",
                      style: textTheme.headlineLarge,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            validator: validateEmail,
                            decoration: const InputDecoration(
                              labelText: "メールアドレス",
                              prefixIcon: Icon(Icons.email),
                              hintText: "your@email.com",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "パスワード",
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                onPressed: toggleVisiblePassword,
                                icon: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                            obscureText: !showPassword,
                          ),
                          FormField(
                            autovalidateMode: AutovalidateMode.always,
                            initialValue: true,
                            validator: (value) => null,
                            builder: (FormFieldState<bool> state) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: _keepLoggedIn,
                                    onChanged: (value) {
                                      setState(
                                          () => _keepLoggedIn = value ?? false);
                                    },
                                  ),
                                  const Text("ログインしたままにする"),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () => context.go("/create-account"),
                              child: const Text("アカウントを作成する"),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FilledButton(
                              onPressed: () =>
                                  print("${_emailController.text}"),
                              child: const Text("ログイン"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
