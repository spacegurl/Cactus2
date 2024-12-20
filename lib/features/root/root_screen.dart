import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  //Заголовки для шапки
  final appBarTitles = <String>[
    'Скан',
    'Википедия растений',
    'История сканов',
    'Профиль',
  ];

  //Текущий индекс страницы
  var currentPageIndex = 0;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      context.read<WikipediaPlantsBloc>().add(WikipediaPlantsFetched());
      context.read<HistoryBloc>().add(HistoryFetched());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[currentPageIndex]),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Theme(
          data: theme.copyWith(
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            onTap: (int index) {
              //setState - обновление состояния, чтобы отобразить другие данные шапки и выбранной иконки в панели
              setState(() {
                currentPageIndex = index;
              });
            },
            currentIndex: currentPageIndex,
            //Кнопки в панели
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined),
                label: 'Скан',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Википедия растений',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'История сканов',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Профиль',
              ),
            ],
          ),
        ),
      ),

      //То, что будет отображено в теле страницы относительно currentPageIndex
      body: <Widget>[
        const ScanPage(),
        const WikipediaPlantsPage(),
        const HistoryPage(),
        const ProfilePage(),
      ][currentPageIndex],
    );
  }
}
