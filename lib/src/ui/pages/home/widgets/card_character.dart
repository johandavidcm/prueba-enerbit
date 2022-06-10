part of 'widgets.dart';

class CardCharacter extends StatelessWidget {
  final Character character;

  const CardCharacter({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: SizedBox(
                height: 170,
                child: Stack(
                  children: [
                    SizedBox(
                      child: Material(
                        child: Ink.image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            character.image,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailPage.routeName,
                              );
                              getIt<CharactersBloc>().add(
                                CharactersEvent.onSelectedCharacterChanged(
                                  character: some(character),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          250,
                        ),
                        child: Container(
                          color: character.isFavorite
                              ? CustomTheme.primaryColor
                              : const Color(0xFF747474),
                          width: 35,
                          height: 35,
                          child: Center(
                            child: Icon(
                              character.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 18,
                              color: CustomTheme.scaffoldBackGround,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              character.name,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            ),
            if (character.status != null)
              TextStatusCharacter(character: character),
          ],
        ),
      ),
    );
  }
}
