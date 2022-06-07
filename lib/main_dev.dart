import 'main_common.dart';
import 'src/config/env_config.dart';

/// En caso de existir 2 o más ambientes en el proyecto este sería el ambiente
/// correspondiente a desarrollo
void main() {
  EnvConfig(
    flavor: Env.dev,
    values: EnvValues(
      baseUrl: 'https://rickandmortyapi.com/api',
      charactersPath: '/character',
      episodesPath: '/episode',
      locationsPath: '/location',
    ),
  );

  mainCommon();
}
