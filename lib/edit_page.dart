import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController memoController;
  late TextEditingController titleController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    memoController = TextEditingController();
    titleController = TextEditingController(text: "Memo");
  }

  @override
  void dispose() {
    memoController.dispose();
    super.dispose();
  }

  void setEditing(bool value) => setState(() => isEditing = value);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isMobile = screen.width < 1000;
    return isMobile
        ? MobileEditLayout(
            titleController: titleController,
            textController: memoController,
          )
        : DesktopEditLayout(
            textController: memoController,
            titleController: titleController,
          );
  }
}

class MobileEditLayout extends StatelessWidget {
  const MobileEditLayout({
    super.key,
    required this.textController,
    required this.titleController,
  });

  final TextEditingController textController;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 400,
          child: TextField(
            controller: titleController,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration.collapsed(hintText: ""),
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AccountButton(),
          ),
        ],
      ),
      body: EditorBody(
        controller: textController,
      ),
      drawer: Drawer(
        child: SideMenuBody(
          items: dummyData,
        ),
      ),
    );
  }
}

class DesktopEditLayout extends StatefulWidget {
  const DesktopEditLayout({
    super.key,
    required this.textController,
    required this.titleController,
  });

  final TextEditingController textController;
  final TextEditingController titleController;

  @override
  State<DesktopEditLayout> createState() => _DesktopEditLayoutState();
}

class _DesktopEditLayoutState extends State<DesktopEditLayout> {
  static bool expandSideMenu = true;

  void toggleSideMenu() => setState(() => expandSideMenu = !expandSideMenu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            width: expandSideMenu ? 300 : 0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: expandSideMenu
                    ? SideMenuBody(
                        items: dummyData,
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    onPressed: toggleSideMenu,
                    icon: const Icon(Icons.menu),
                  ),
                  title: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: widget.titleController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(hintText: ""),
                    ),
                  ),
                  actions: [
                    const AccountButton(),
                  ],
                  centerTitle: true,
                ),
                Expanded(
                  child: EditorBody(
                    controller: widget.textController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditorBody extends StatelessWidget {
  const EditorBody({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        maxLines: 999,
        decoration: const InputDecoration.collapsed(hintText: null),
      ),
    );
  }
}

class SideMenuBody extends StatelessWidget {
  final List<MemoData> items;

  const SideMenuBody({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(items[index].title ?? "undefined"),
              subtitle: Text(items[index].lastEditingDate?.toString() ?? ""),
            ),
          ),
        ),
      ],
    );
  }
}

class SidebarTile extends StatelessWidget {
  const SidebarTile({super.key, this.title, this.lastEditDate});

  final String? title;
  final DateTime? lastEditDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title ?? "undefined"),
      subtitle: Text(
        lastEditDate?.toString() ?? DateTime.now().toString(),
      ),
    );
  }
}

class AccountButton extends StatelessWidget {
  const AccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogin = FirebaseAuth.instance.currentUser != null;

    return PopupMenuButton(
      itemBuilder: (context) => [
        if (isLogin == false)
          PopupMenuItem(
            onTap: () => context.go("/login"),
            child: const Text("ログイン"),
          )
        else
          PopupMenuItem(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              context.go("/");
            },
            child: const Text("ログアウト"),
          ),
        const PopupMenuItem(child: Text("設定")),
      ],
      child: const CircleAvatar(),
    );
  }
}

class MemoData {
  final String? title;
  final String? text;
  final DateTime? lastEditingDate;

  MemoData({this.text, this.title, this.lastEditingDate});
}

final dummyData = <MemoData>[
  MemoData(
    title: "使い方",
    lastEditingDate: DateTime.now(),
  ),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData(),
];
