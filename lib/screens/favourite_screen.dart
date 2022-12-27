import 'package:briskit/getit.dart';
import 'package:briskit/screens/post_over_view.dart';
import 'package:briskit/utils/base_view_modal.dart';
import 'package:briskit/utils/color_util.dart';
import 'package:briskit/viewModel/movie_view_model.dart';
import 'package:briskit/widgets/custom_loader.dart';
import 'package:briskit/widgets/movie_list_widget.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<MovieViewModel>(
        model: getIt(),
        initState: (init) {
          Future.delayed(Duration.zero, () => init.getMovies(context));
        },
        builder: (mVm, _) {
          return Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: kcEEEDED,
                centerTitle: true,
                title: Text('My Favourite',
                    style: TextStyle(color: kcBlack.withOpacity(0.7)))),
            body: BaseViewBuilder<MovieViewModel>(
                model: getIt(),
                initState: (init) {
                  Future.delayed(Duration.zero, () => init.getMovies(context));
                },
                builder: (mVm, _) {
                  return mVm.cachedMovieModel == null
                      ? const CustomLoader()
                      : mVm.favourieItem!.isEmpty
                          ? const Center(
                              child: Text('No favourite movie'),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(top: 20),
                              physics: const BouncingScrollPhysics(),
                              itemCount: mVm.favourieItem!.length,
                              itemBuilder: (context, index) {
                                final item = mVm.favourieItem![index];
                                return GestureDetector(
                                  onTap: () {
                                    //Set current selected movie
                                    mVm.setSelectedMovieItem(item);
                                    Navigator.of(context).pushNamed(
                                        PostOverviewScreen.routeName);
                                  },
                                  child: MovieListWidget(item: item),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 30,
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.7),
                                    thickness: 3,
                                  ),
                                );
                              },
                            );
                }),
          );
        });
  }
}
