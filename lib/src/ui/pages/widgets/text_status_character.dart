part of 'widgets.dart';

class TextStatusCharacter extends StatelessWidget {
  final double? widthText;

  const TextStatusCharacter({
    Key? key,
    this.widthText,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          ColorStatusCharacter(character: character),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: widthText,
            child: Text(
              character.status?.toSpanishString ?? '',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: CustomTheme.greyTextColor,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
}
