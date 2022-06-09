part of 'widgets.dart';

class ColorStatusCharacter extends StatelessWidget {
  final Character character;
  final double width;
  final double height;

  const ColorStatusCharacter({
    Key? key,
    this.width = 10,
    this.height = 10,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: character.status == Status.alive
              ? Theme.of(context).primaryColor
              : character.status == Status.unknown
                  ? CustomTheme.warningColor
                  : Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(100),
        ),
      );
}
