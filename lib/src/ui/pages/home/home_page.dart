import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/characters/characters_bloc.dart';
import '../../../dependencies.dart';
import '../../../models/characters/character.dart';
import '../../layouts/default_layout.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _defaultViewScrollController = ScrollController();

  bool get _isBottom {
    if (!_defaultViewScrollController.hasClients) return false;
    final currentScroll = _defaultViewScrollController.offset;
    return currentScroll >=
        (_defaultViewScrollController.position.maxScrollExtent * 0.9);
  }

  @override
  void initState() {
    getIt<CharactersBloc>().add(
      const CharactersEvent.onNextPageRequested(),
    );
    _defaultViewScrollController.addListener(
      () {
        if (_isBottom &&
            !getIt<CharactersBloc>().state.hasReachedMax &&
            !getIt<CharactersBloc>().state.isRequestingCharacters) {
          getIt<CharactersBloc>().add(
            const CharactersEvent.onNextPageRequested(),
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _defaultViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultLayout(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(
              FocusNode(),
            ),
            child: BlocBuilder<CharactersBloc, CharactersState>(
              bloc: getIt<CharactersBloc>(),
              builder: (context, state) => SingleChildScrollView(
                controller: _defaultViewScrollController,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline5,
                          children: [
                            const TextSpan(text: 'Personajes '),
                            TextSpan(
                              text: 'Rick y Morty',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value) => getIt<CharactersBloc>().add(
                          CharactersEvent.onNextPageRequested(
                            searchTerm: value,
                          ),
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          label: Text('Buscar personajes'),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (state.isRequestingCharacters &&
                          state.characters.isEmpty)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      _Cards(
                        characters: state.characters,
                      ),
                      if (!state.hasReachedMax &&
                          state.characters.isNotEmpty &&
                          !state.hasReachedMax)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Cards extends StatelessWidget {
  final List<Character> characters;

  const _Cards({
    Key? key,
    required this.characters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...characters.map(
          (character) => CardCharacter(
            character: character,
          ),
        ),
      ],
    );
  }
}
