import 'package:delalo/delalo_app/blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/data_provider/auth_data/login_data.dart';
import 'package:delalo/delalo_app/data_provider/auth_data/singupUser_data.dart';
import 'package:delalo/delalo_app/data_provider/data_provider.dart';
import 'package:delalo/delalo_app/repository/auth_repository/login_repository.dart';
import 'package:delalo/delalo_app/repository/auth_repository/signupProvider_repository.dart';
import 'package:delalo/delalo_app/repository/auth_repository/signupUser_repository.dart';
import 'package:delalo/delalo_app/repository/user_repository/order_jobs_repository.dart';
import 'package:delalo/delalo_app/repository/user_repository/provider_list_repository.dart';
import 'package:delalo/delalo_app/repository/user_repository/search_repository.dart';
import 'package:delalo/delalo_app/screens/navigation_drawer/navigation.dart';
import 'package:delalo/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:delalo/delalo_app/repository/user_repository/category_repository.dart';
import 'blocs/auth_bloc/signupProvider_bloc/signupProvider_bloc.dart';
import 'blocs/auth_bloc/signupUser_bloc/signupUser_bloc.dart';
import 'blocs/provider_list_bloc/provider_list_bloc.dart';
import 'blocs/provider_list_bloc/provider_list_event.dart';
import 'blocs/search_bloc/search_bloc.dart';
import 'data_provider/auth_data/singupProvider_data.dart';
import 'data_provider/user_data/category_data.dart';
import 'data_provider/user_data/provider_list_data.dart';
import 'data_provider/user_data/search_data.dart';

class MyApp extends StatelessWidget {
  final String category="gfd";
  static final httpClient = http.Client();
  final orderRepository = OrderRepository(
      dataProvider: OrderDataProvider(
    httpClient: httpClient,
  ));

  final loginRepository =
      LoginRepository(dataProvider: LoginDataProvider(httpClient: httpClient));
  final signupUserRepository = SignupUserRepository(
      dataProvider: SignupUserDataProvider(httpClient: httpClient));
  final signupProviderRepository = SignupProviderRepository(
      dataProvider: SignupProviderDataProvider(httpClient: httpClient));    
  final CategoryRepository categoryRepository = CategoryRepository(
  dataProvider: CategoryDataProvider(
    httpClient: http.Client(),
    ),
  );
  final searchRepository= SearchCategoryRepository(searchCategoryDataProvider: SearchCategoryDataProvider(httpClient: http.Client()) );
  final providerListRepository = ProviderListRepository(providerListDataProvider: ProviderListDataProvider(httpClient: http.Client()));
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
            create: (context) => LoginBloc(loginRepository: loginRepository)),
        BlocProvider(
            create: (context) =>
                SignupUserBloc(signupUserRepository: signupUserRepository)),
        BlocProvider(
            create: (context) =>
                SignupProviderBloc(signupProviderRepository: signupProviderRepository)),
        BlocProvider(
                create: (context) =>
                    CategoryBloc(categoryRepository: categoryRepository)
                      ..add(
                        CategoriesLoad(),
                      ),

        ),
        BlocProvider<SearchBloc>(
        create: (context)=> SearchBloc(searchRepository: searchRepository)
        ),
         BlocProvider<ProviderListBloc>(
          create: (cntx)=> ProviderListBloc(providerListRepository: providerListRepository)..add(ProviderListLoad(category: category))),
      ],
      child: MaterialApp(
        home: Scaffold(
          drawer: NavigationDrawer(),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerator.providerListPage,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
