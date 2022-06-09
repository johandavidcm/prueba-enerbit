part of 'widgets.dart';

class DetailCharacterData extends StatelessWidget {
  final String title;

  final String description;
  const DetailCharacterData({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: CustomTheme.greyTextColor,
                ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              description,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
}
