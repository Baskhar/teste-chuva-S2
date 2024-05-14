import 'package:chuva_dart/app/data/models/event_model.dart';
import 'package:chuva_dart/app/models/person_model.dart';
import 'package:chuva_dart/app/modules/envent_module/event_screen.dart';
import 'package:chuva_dart/app/modules/home_module/home_screen.dart';

import 'package:go_router/go_router.dart';

import '../modules/people_module/people_screen.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => HomeScreen(),
  ),
  GoRoute(
      path: '/event',
      name: '/event',
      builder: (context, state) {
        final EventModelTeste event = state.extra as EventModelTeste;
        return EventScreen(event: event);

      }),
  GoRoute(
      path: '/people',
      name: '/people',
      builder: (context, state) {
        final event = state.extra as Person;
        return PeopleScreen(
          name: event.name,
          bio: event.bio,
          foto: event.picture,
          institution: event.institution,
        );
      }),
]);
