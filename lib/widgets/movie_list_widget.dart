
import 'package:briskit/model/movie_model.dart';
import 'package:briskit/utils/text_style.dart';
import 'package:briskit/widgets/custom_catch_image_widget.dart';
import 'package:briskit/widgets/label_button.dart';
import 'package:flutter/material.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Items? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      padding: const EdgeInsets.only(left: 20),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            width: 130,
            color: Colors.red,
            child: CustomCatchImageWidget(
              imageUrl: item!.image!,
            ),
          ),
          Expanded(
            child: Container(
              height: 140,
              padding: const EdgeInsets.only(
                  left: 20, right: 20),
              child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item!.fullTitle}',
                          style: stBlack60015,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          'by ${item!.crew}',
                          style: stGrey40014,
                        ),
                      ],
                    ),
                    LabelButton(
                        title: 'LABEL ${item!.rank}'),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.star_border),
                        Transform.translate(
                          offset: const Offset(0, -4),
                          child: Text(
                            '  ${item!.imDbRating} Rates',
                            style: stGrey40014,
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
