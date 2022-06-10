import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart' show none;

import '../../../blocs/characters/characters_bloc.dart';
import '../../../dependencies.dart';
import '../../../enums/enums.dart';
import '../../theme/custom_theme.dart';
import '../widgets/widgets.dart';
import 'widgets/widgets.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detailpage';

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    getIt<CharactersBloc>().add(
      CharactersEvent.onSelectedCharacterChanged(
        character: none(),
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharactersBloc, CharactersState>(
        bloc: getIt<CharactersBloc>(),
        builder: (context, state) {
          if (state.isLoadingDetail) {
            return const SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final character = state.selectedCharacter.getOrElse(() => null);
          if (character != null) {
            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
            );
          }
          return SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: character == null
                ? Center(
                    child: Text(
                      'No se ha seleccionado ningun personaje previamente',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Stack(
                    children: [
                      Positioned(
                        child: Container(
                          width: double.maxFinite,
                          height: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                character.image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 330,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.58,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 25,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CharacterCardsDetail(
                                      title: 'Estado',
                                      child: TextStatusCharacter(
                                        character: character,
                                        widthText: 80,
                                      ),
                                    ),
                                    CharacterCardsDetail(
                                      title: 'Especie',
                                      child: Text(
                                        character.species?.toSpanishString ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                    CharacterCardsDetail(
                                      title: 'Genero',
                                      child: Text(
                                        character.gender?.toSpanishString ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Datos personaje',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                DetailCharacterData(
                                  title: 'Tipo',
                                  description: character.type.isEmpty
                                      ? 'Desconocido'
                                      : character.type,
                                ),
                                DetailCharacterData(
                                  title: 'Debut',
                                  description:
                                      character.firstEpisode?.name ?? '',
                                ),
                                DetailCharacterData(
                                  title: 'Locación',
                                  description: character.location.name,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      if (!character.isFavorite) {
                                        getIt<CharactersBloc>().add(
                                          CharactersEvent
                                              .onAddToFavoriteRequested(
                                            character: character,
                                          ),
                                        );
                                      } else {
                                        getIt<CharactersBloc>().add(
                                          CharactersEvent
                                              .onDeleteFavoriteRequested(
                                            character: character,
                                          ),
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          character.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: CustomTheme.primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        character.isFavorite
                                            ? const Text(
                                                'Eliminar de favoritos')
                                            : const Text('Añadir a favoritos'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (Navigator.canPop(context))
                        Positioned(
                          top: 50,
                          left: 20,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
