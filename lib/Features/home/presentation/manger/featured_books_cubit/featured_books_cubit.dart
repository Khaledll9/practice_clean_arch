import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:meta/meta.dart';

import '../../../domain/entities/book_entity.dart';
import '../../../domain/use_cases/fetch_featured_books_use_case.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  final FetchFeaturedBooksUseCase featuredBooksUseCase;

  FeaturedBooksCubit(this.featuredBooksUseCase) : super(FeaturedBooksInitial());
  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    var result = await featuredBooksUseCase.call();
    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.message));
      },
      (books) {
        emit(FeaturedBooksSuccess(books));
      },
    );
  }
}
