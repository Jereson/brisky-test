import 'package:briskit/getit.dart';
import 'package:briskit/model/movie_model.dart';
import 'package:briskit/services/movies_services.dart';
import 'package:briskit/utils/basic_utils.dart';
import 'package:briskit/utils/error_code.dart';
import 'package:briskit/utils/flushbar_util.dart';
import 'package:briskit/viewModel/base_view_model.dart';
import 'package:briskit/widgets/custom_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class MovieViewModel extends BaseViewModel {
  MovieModel? cachedMovieModel;
  Items? selectedMovieItem;
  List<Items>? searchItem = [];
  List<Items>? favourieItem = [];

  String searchTerm = '';
  bool isSearching = false;
  bool startSearching = false;

  final searchTermController = TextEditingController();

  final apiResonse = getIt.get<MoviesServices>();

  //get Movie from service 
  Future<void> getMovies(BuildContext context, [bool isFav = false]) async {
    final result = await apiResonse.getMovies();
    if (result is RepoSucess) {
      cachedMovieModel = MovieModel.fromJson(result.data);
      setState();
      // logger.d(result.data);
    
    } else {
      logger.d('Error');
    }
  }

//Add movie to user favourite
  Future<void> addFavouriteMovie(BuildContext context, String id) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      progressDialog.show();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final dataSource = firestore.collection('user').doc(user.uid);

      //Update and get user collection
        await dataSource.update({
          'favorite': FieldValue.arrayUnion([id])
        });

        await userDetail();

        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'Favourite',
            message: 'Movie added to your favourite',
            isSuccess: true);
      }
    } on FirebaseAuthException catch (error) {
      progressDialog.dismiss();
      firebaseErrorCode(context, error.code);
    } catch (e) {
      progressDialog.dismiss();
      otherExeption(context, e);
    }
  }

//set movie selected by index
  void setSelectedMovieItem(Items items) {
    selectedMovieItem = items;
  }

//Searc for movie by topic
  searchMovies(String searchWord) {
    if (searchWord.isEmpty) {
      isSearching = false;
      setState();
    } else {
      searchItem = cachedMovieModel?.items!
          .where((data) => data.fullTitle!
              .toLowerCase()
              .contains(searchWord.trim().toLowerCase()))
          .toList();

      isSearching = false;
      setState();
    }
  }

  void setStartSearch() {
    startSearching = !startSearching;
    if (!startSearching) {
      searchTermController.clear();
    }
    setState();
  }

  getFavouritMovie() {
    favourieItem = cachedMovieModel?.items!
        .where((data) => cachedUserModel!.favorite!.contains(data.id))
        .toList();

    setState();
  }
}
