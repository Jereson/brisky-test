import 'package:briskit/getit.dart';
import 'package:briskit/screens/post_over_view.dart';
import 'package:briskit/utils/base_view_modal.dart';
import 'package:briskit/utils/color_util.dart';
import 'package:briskit/utils/form_decoration_util.dart';
import 'package:briskit/viewModel/movie_view_model.dart';
import 'package:briskit/widgets/custom_loader.dart';
import 'package:briskit/widgets/movie_list_widget.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
              title: !mVm.startSearching
                  ? Text('Explorer',
                      style: TextStyle(color: kcBlack.withOpacity(0.7)))
                  : Form(
                      key: formKey,
                      child: TextField(
                        controller: mVm.searchTermController,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'Search'),
                        onChanged: (value) {
                          //Start search by keystroke move
                          mVm.searchMovies(value);
                        },
                      ),
                    ),
              actions: [
                !mVm.startSearching
                    ? TextButton(
                        onPressed: () {
                          //Initail search button
                          mVm.setStartSearch();
                        },
                        child: const Text(
                          'Filter',
                          style: TextStyle(color: kcBlack),
                        ))
                    : TextButton(
                        onPressed: () {
                          //Terminate search functionality
                          mVm.setStartSearch();
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.red),
                        ))
              ],
            ),
            body: BaseViewBuilder<MovieViewModel>(
                model: getIt(),
                initState: (init) {
                  //Get Movies by init state with provider
                  Future.delayed(Duration.zero, () => init.getMovies(context));
                },
                builder: (mVm, _) {
                  return mVm.cachedMovieModel == null
                      ? const CustomLoader()
                      : mVm.cachedMovieModel!.items!.isEmpty
                          ? const Center(
                              child: Text('No movie availabe yet!'),
                            )
                          : mVm.startSearching && mVm.searchItem!.isEmpty
                              ? const Center(
                                  child:
                                      Text('No search result, make new search'),
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.only(top: 20),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      mVm.searchTermController.text.isEmpty
                                          ? mVm.cachedMovieModel!.items!.length
                                          : mVm.searchItem!.length,
                                  itemBuilder: (context, index) {
                                    final item = mVm
                                            .searchTermController.text.isEmpty
                                        ? mVm.cachedMovieModel?.items![index]
                                        : mVm.searchItem![index];
                                    return GestureDetector(
                                      onTap: () {
                                        //Set current selected movie
                                        mVm.setSelectedMovieItem(item!);
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
