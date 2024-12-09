import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool showPassword = false;

  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController1;
  late TextEditingController _passwordController2;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController1 = TextEditingController();
    _passwordController2 = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  String? validateUserName(String? userName) {
    if (userName?.isEmpty ?? true) {
      return "ユーザー名を入力してください";
    }

    return null;
  }

  String? validateEmail(String? email) {
    if (email?.isEmpty ?? true) return "メールアドレスを入力してください";

    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (email != null && !regex.hasMatch(email)) {
      return "有効なメールアドレスを入力してください";
    }

    return null;
  }

  String? validatePassword1(String? password) {
    if (password?.isEmpty ?? true) {
      return "パスワードを入力してください";
    }

    if (password!.length < 6) {
      return "パスワードは6文字以上にしてください";
    }

    if (password != _passwordController2.text) {
      return "パスワードが一致しません";
    }

    return null;
  }

  String? validatePassword2(String? password) {
    if (password?.isEmpty ?? true) {
      return "パスワードを入力してください";
    }

    if (password != _passwordController1.text) {
      return "パスワードが一致しません";
    }

    return null;
  }

  _createAccount(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final isValid = _formKey.currentState?.validate() ?? true;

    if (!isValid) return;

    try {
      // Firebase Authentication でユーザーを作成
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController1.text,
      );

      // Firestore にユーザー名を保存
      final user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _userNameController.text,
          'email': _emailController.text,
        });
      }

      // アカウント作成後、ホームページに遷移
      context.go("/");
    } catch (e) {
      // エラーが発生した場合
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("アカウント作成に失敗しました: $e")),
      );
    }
  }

  void toggleVisiblePassword() => setState(() => showPassword = !showPassword);

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
                key: _formKey,
                child: SizedBox(
                  height: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        validator: validateUserName,
                        decoration: const InputDecoration(
                          labelText: "ユーザー名",
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: "your name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: validateEmail,
                        decoration: const InputDecoration(
                          labelText: "メールアドレス",
                          prefixIcon: Icon(Icons.email),
                          hintText: "your@email.com",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController1,
                        validator: validatePassword1,
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
                        controller: _passwordController2,
                        validator: validatePassword2,
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
                          onPressed: () => _createAccount(context),
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
