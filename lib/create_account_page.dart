import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48.0),
                child: Text(
                  "アカウントを作成",
                  style: textTheme.headlineLarge,
                ),
              ),
              Form(
                child: SizedBox(
                  height: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "ユーザー名",
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: "your name",
                          border: OutlineInputBorder(),
                        ),
                      ),
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
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "パスワード (再入力)",
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
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => context.go("/login"),
                          child: const Text("ログイン"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: () => context.go("/"),
                          child: const Text("アカウントを作成"),
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
    );
  }
}
