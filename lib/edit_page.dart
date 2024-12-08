import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController controller;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setEditing(bool value) => setState(() => isEditing = value);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isMobile = screen.width < 1000;
    return isMobile
        ? MobileEditLayout(
            controller: controller,
          )
        : DesktopEditLayout(
            controller: controller,
          );
  }
}

class MobileEditLayout extends StatelessWidget {
  const MobileEditLayout({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Memo"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AccountButton(),
          ),
        ],
      ),
      body: EditorBody(
        controller: TextEditingController(),
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
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<DesktopEditLayout> createState() => _DesktopEditLayoutState();
}

class _DesktopEditLayoutState extends State<DesktopEditLayout> {
  bool expandSideMenu = true;

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
              padding: EdgeInsets.all(8.0),
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
                  title: Text("Memo"),
                  actions: [
                    AccountButton(),
                  ],
                  centerTitle: true,
                ),
                Expanded(
                  child: EditorBody(
                    controller: widget.controller,
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
        decoration: InputDecoration.collapsed(hintText: null),
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
              onTap: () => print("Tapped: ${items[index]}"),
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
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () => context.go("/login"),
          child: const Text("ログイン"),
        ),
        PopupMenuItem(child: Text("設定")),
      ],
      child: const CircleAvatar(),
    );
  }
}

class MemoData {
  final String? title;
  final DateTime? lastEditingDate;

  MemoData({this.title, this.lastEditingDate});
}

final dummyData = <MemoData>[
  MemoData(
    title: "使い方",
    lastEditingDate: DateTime.now(),
  ),
  MemoData(),
  MemoData(),
  MemoData(),
  MemoData()
];
