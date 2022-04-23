import 'package:flutter_modular/flutter_modular.dart';

import 'movie_app.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const MovieApp()),
        RedirectRoute('/redirect', to: '/'),
      ];
}
