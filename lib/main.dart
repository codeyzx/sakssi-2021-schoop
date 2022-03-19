import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoop/cubit/auth_cubit.dart';
import 'package:schoop/cubit/page_cubit.dart';
import 'package:schoop/models/bot_navbar.dart';
import 'package:schoop/ui/onboard/login_screen.dart';
import 'package:schoop/ui/onboard/onboarding_schoop_page.dart';
import 'package:schoop/ui/onboard/signup_screen.dart';
import 'package:schoop/ui/onboard/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  initScreen = await pref.getInt('initScreen');
  await pref.setInt('initScreen', 1);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(411, 731),
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/onBoarding': (context) => OnBoardingSchoopPage(),
              '/splash': (context) => SplashPage(),
              '/sign-in': (context) => LoginScreen(),
              '/sign-up': (context) => SignUpScreen(),
              '/nav-bar': (context) => NavBar(),
            },
            initialRoute: initScreen == 0 || initScreen == null
                ? '/onBoarding'
                : '/splash'),
      ),
    );
  }
}
