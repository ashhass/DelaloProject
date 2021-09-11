import 'package:delalo/delalo_app/blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/data_provider/auth_data/login_data.dart';
import 'package:delalo/delalo_app/data_provider/auth_data/singupUser_data.dart';
import 'package:delalo/delalo_app/data_provider/data_provider.dart';
import 'package:delalo/delalo_app/data_provider/user_data/review_data.dart';
import 'package:delalo/delalo_app/repository/auth_repository/login_repository.dart';
import 'package:delalo/delalo_app/repository/auth_repository/signupProvider_repository.dart';
import 'package:delalo/delalo_app/repository/auth_repository/signupUser_repository.dart';
import 'package:delalo/delalo_app/repository/user_repository/order_jobs_repository.dart';
import 'package:delalo/delalo_app/repository/user_repository/review_repository.dart';
import 'package:delalo/delalo_app/screens/navigation_drawer/navigation.dart';
import 'package:delalo/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/auth_bloc/signupProvider_bloc/signupProvider_bloc.dart';
import 'blocs/auth_bloc/signupUser_bloc/signupUser_bloc.dart';
import 'data_provider/auth_data/singupProvider_data.dart';

class MyApp extends StatelessWidget {
  static final httpClient = http.Client();
  final orderRepository = OrderRepository(
      dataProvider: OrderDataProvider(
    httpClient: http.Client(),
  ));
  final reviiewRepository = ReviewRepository(
      reviewDataProvider: ReviewDataProvider(
    httpClient: http.Client(),
  ));
  final loginRepository =
      LoginRepository(dataProvider: LoginDataProvider(httpClient: httpClient));
  final signupUserRepository = SignupUserRepository(
      dataProvider: SignupUserDataProvider(httpClient: httpClient));
  final signupProviderRepository = SignupProviderRepository(
      dataProvider: SignupProviderDataProvider(httpClient: httpClient));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderBloc(orderRepository: orderRepository)
            ..add(
              OrdersLoad(),
            ),
        ),
        BlocProvider(
          create: (context) => ReviewBloc(reviewRepository: reviiewRepository)
            ..add(
              ReviewLoad(),
            ),
        ),
        BlocProvider(
            create: (context) => LoginBloc(loginRepository: loginRepository)),
        BlocProvider(
            create: (context) =>
                SignupUserBloc(signupUserRepository: signupUserRepository)),
        BlocProvider(
            create: (context) => SignupProviderBloc(
                signupProviderRepository: signupProviderRepository))
      ],
      child: MaterialApp(
        home: Scaffold(
          drawer: NavigationDrawer(),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerator.ordersScreenName,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
