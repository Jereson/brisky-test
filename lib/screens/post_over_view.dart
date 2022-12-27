import 'package:briskit/getit.dart';
import 'package:briskit/utils/base_view_modal.dart';
import 'package:briskit/utils/color_util.dart';
import 'package:briskit/utils/text_style.dart';
import 'package:briskit/viewModel/movie_view_model.dart';
import 'package:briskit/widgets/custom_catch_image_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PostOverviewScreen extends StatefulWidget {
  static const routeName = 'post-overview';
  const PostOverviewScreen({Key? key}) : super(key: key);

  @override
  State<PostOverviewScreen> createState() => _PostOverviewScreenState();
}

class _PostOverviewScreenState extends State<PostOverviewScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BaseViewBuilder<MovieViewModel>(
            model: getIt(),
            builder: (mVm, _) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      alignment: Alignment.topCenter,
                      color: Colors.red,
                      child: CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                            viewportFraction: 1,
                            height: MediaQuery.of(context).size.height * 0.55,
                            reverse: false,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: [mVm.selectedMovieItem!.image].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CustomCatchImageWidget(imageUrl: i!);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [0].map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry ? 0.7 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mVm.selectedMovieItem!.fullTitle!,
                            style: stBlack60015,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'by ${mVm.selectedMovieItem!.crew}',
                            style: stGrey40014,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Transform.translate(
                                  offset: const Offset(-12, 0),
                                  child: const Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              // const SizedBox(width: 0),
                              BorderButton(
                                title: 'Like',
                                iconData: Icons.thumb_up,
                                callback: () {},
                              ),
                              const SizedBox(width: 10),
                              BorderButton(
                                title: 'Comment',
                                iconData: Icons.comment_bank_rounded,
                                callback: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation \n\nUllamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
