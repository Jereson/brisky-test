import 'package:briskit/services/movies_services.dart';
import 'package:briskit/viewModel/auth_view_model.dart';
import 'package:briskit/viewModel/movie_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup()  {
  getIt.registerSingleton<MoviesServices>(MoviesServices());
  getIt.registerSingleton<MovieViewModel>(MovieViewModel());
  getIt.registerSingleton<AuthViewModel>(AuthViewModel());
  
}
