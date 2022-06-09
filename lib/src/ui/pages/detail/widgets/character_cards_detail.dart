part of 'widgets.dart';

class CharacterCardsDetail extends StatelessWidget {
  final String title;
  final Widget child;

  const CharacterCardsDetail({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.27,
        decoration: BoxDecoration(
          color: CustomTheme.disabledColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: CustomTheme.greyTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              child,
            ],
          ),
        ),
      );
}
