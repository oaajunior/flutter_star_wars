@TestOn('vm')

import 'package:app_star_wars/utils/loading_status.dart';
import 'package:app_star_wars/view_model/characters/characters_list_films_view_model.dart';
import 'package:test/test.dart';
import '../../helper/services/mocked_starwars_service.dart';

main() {
  group('Test CharactersListFilmsViewModel', () {
    CharactersListFilmsViewModel viewModel;

    setUpAll(() {
      viewModel = CharactersListFilmsViewModel();
    });

    test('Initial state', () {
      expect(viewModel.filmResponse, isNotNull);
      expect(viewModel.service, isNotNull);
    });

    test('Feed data source with real network', () async {
      var filmId = 1;
      expect(viewModel.loadingStatus, LoadingStatus.loading);
      await viewModel.feedDataSource(filmId: filmId);
      expect(viewModel.loadingStatus, LoadingStatus.completed);
    });

    test('Feed data source with real network with a null argument', () async {
      var filmId;
      await viewModel.feedDataSource(filmId: filmId);
      expect(viewModel.loadingStatus, LoadingStatus.empty);
    });

    test('Feed data source with a mocked network', () async {
      var filmId = 1;
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource(filmId: filmId);
      expect(viewModel.loadingStatus, LoadingStatus.completed);
    });

    test('Testing empty state with mocked network', () async {
      var filmId = 4;
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource(filmId: filmId);
      expect(viewModel.loadingStatus, LoadingStatus.empty);
    });

    test('Testing error state with mocked network', () async {
      var filmId = 4;
      viewModel.service = MockedStarWarsService(state: MockedState.error);
      await viewModel.feedDataSource(filmId: filmId);
      expect(viewModel.loadingStatus, LoadingStatus.error);
    });
  });
}
