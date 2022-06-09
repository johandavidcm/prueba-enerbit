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
                height: MediaQuery.of(context).size.width * 0.4,
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
                            onTap: () => Navigator.pushNamed(
                              context,
                              DetailPage.routeName,
                              arguments: character,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          250,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Hacer guardado en localstorage
                          },
                          child: Container(
                            color: const Color(0xFF747474),
                            width: 40,
                            height: 40,
                            child: const Center(
                              child: Icon(
                                Icons.favorite_border,
                                color: CustomTheme.scaffoldBackGround,
                              ),
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
