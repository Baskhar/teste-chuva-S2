
import 'package:chuva_dart/app/app_widget.dart';
import 'package:chuva_dart/app/data/storage/event_id_storage.dart';
import 'package:chuva_dart/app/modules/home_module/home_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/http/http_client.dart';
import 'data/repositories/event_repository.dart';



class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventIdStorage>(
          create: (context) => EventIdStorage(),
        ),
        Provider<EventStore>(
          create: (_) => EventStore(repository: EventRepository(client: HttpClient())),
        ),

      ],
      child: AppWidget(),
    );
  }
}
