import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  void toggleVisiblePassword() {
    setState(() => showPassword = !showPassword);
  }

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
            constraints: BoxConstraints(maxWidth: 1000),
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
                    child: SizedBox(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
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
                              prefixIcon: Icon(Icons.key),
                              suffixIcon: IconButton(
                                onPressed: toggleVisiblePassword,
                                icon: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: OutlineInputBorder(),
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
                                    value: state.value,
                                    onChanged: state.didChange,
                                  ),
                                  Text("ログインしたままにする"),
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
                              onPressed: () => context.go("/"),
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
