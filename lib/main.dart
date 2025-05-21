import 'package:flutter/material.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';
import 'package:games_deal_tracking/data/repositories/deals_remote_data_repo_impl.dart';
import 'package:games_deal_tracking/data/services/api_service.dart';
import 'package:games_deal_tracking/view/screens/home_screen.dart';
import 'package:games_deal_tracking/view/viewModel/home_view_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(GameDealModelAdapter());

  await Hive.openBox<GameDealModel>('gameDeals');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),

        Provider<DealsRemoteDataRepoImpl>(
          create: (context) =>
              DealsRemoteDataRepoImpl(context.read<ApiService>()),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) {
            final viewModel = HomeViewModel(context.read<DealsRemoteDataRepoImpl>());
            viewModel.fetchDeals();
            return viewModel;
          }
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
