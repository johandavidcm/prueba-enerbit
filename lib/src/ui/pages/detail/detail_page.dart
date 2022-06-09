import 'package:flutter/material.dart';

import '../../../models/characters/character.dart';
import '../../../enums/enums.dart';
import '../../theme/custom_theme.dart';
import '../widgets/widgets.dart';
import 'widgets/widgets.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detailpage';

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)?.settings.arguments as Character?;
    return Scaffold(
      body: SizedBox(
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
                      height: 500,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    character.species?.toSpanishString ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                CharacterCardsDetail(
                                  title: 'Genero',
                                  child: Text(
                                    character.gender?.toSpanishString ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Descripción',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              CustomTheme.loremIpsum,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: CustomTheme.greyTextColor),
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
                              description: character.type.isEmpty
                                  ? 'Desconocido'
                                  : character.type,
                            ),
                            DetailCharacterData(
                              title: 'Locación',
                              description: character.location.name,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.favorite_border,
                                      color: CustomTheme.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Añadir a favoritos'),
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
      ),
    );
  }
}
