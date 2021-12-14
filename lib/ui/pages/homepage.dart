import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_vired/bl/blocs/authblock.dart';
import 'package:hero_vired/bl/blocs/homepagebloc.dart';
import 'package:hero_vired/bl/model/authmodel/olduserresponse.dart';
import 'package:hero_vired/ui/pages/courselist.dart';
import 'package:hero_vired/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final HomePageBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomePageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            SharedPreferences pref = snap.data as SharedPreferences;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                Text(
                  "Hello ${pref.getString("userName")!}",
                  style: Theme.of(context).textTheme.headline1!.merge(
                      const TextStyle(fontSize: 26, color: Colors.black87)),
                ),
              ]),
            );
          } else {
            return Loader();
          }
        },
      ),
      bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 20,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: Colors.white,
                  ),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: const Color.fromRGBO(155, 155, 155, 1),
            selectedItemColor: Colors.amber[800],
            onTap: (page) {
              if (page == 2) {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return CourseList(bloc: bloc);
                    });
              }
            },
          )),
    ));
  }
}
