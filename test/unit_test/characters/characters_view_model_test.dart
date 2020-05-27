import 'package:app_star_wars/services/starwars_service.dart';
import 'package:app_star_wars/utils/loading_status.dart';
import 'package:app_star_wars/view_model/characters/characters_view_model.dart';
import 'package:test/test.dart';
import '../../helper/services/mocked_starwars_service.dart';

main() {
  group('Test CharactersViewModel', () {
    CharactersViewModel viewModel;

    setUpAll(() {
      viewModel = CharactersViewModel();
    });

    test('Initial state', () {
      expect(viewModel.service, isNotNull);
      expect(viewModel.isNextPage, isTrue);
      expect(viewModel.nextPage, isEmpty);
      expect(viewModel.previousPage, isEmpty);
      expect(viewModel.dataSource, isEmpty);
      expect(viewModel.service, isNotNull);
    });

    test('Feed data source with real network', () async {
      expect(viewModel.loadingStatus, LoadingStatus.loading);
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 10);
    });

    test('Feed data source with mocked network', () async {
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 4);
    });

    test('Testing loading state with mocked network', () {
      viewModel.service = MockedStarWarsService();
      viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.loading);
    });

    test('Testing error state with mocked network', () async {
      viewModel.service = MockedStarWarsService(state: MockedState.error);
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.error);
    });

    test('Feed data source by passing a empty page with real network',
        () async {
      viewModel.nextPage = '';
      viewModel.service = StarWarsServiceImpl();
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 10);
      expect(viewModel.isNextPage, isTrue);
      expect(viewModel.nextPage, '?page=2');
      expect(viewModel.previousPage, '');
    });

    test('Feed data source by passing a next page with real network', () async {
      viewModel.nextPage = '?page=3';
      viewModel.service = StarWarsServiceImpl();
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 10);
      expect(viewModel.isNextPage, isTrue);
      expect(viewModel.nextPage, '?page=4');
      expect(viewModel.previousPage, '?page=2');
    });

    test('Feed data source by passing a previous page with real network',
        () async {
      viewModel.previousPage = '?page=2';
      viewModel.isNextPage = false;
      viewModel.service = StarWarsServiceImpl();
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 10);
      expect(viewModel.isNextPage, isFalse);
      expect(viewModel.nextPage, '?page=3');
      expect(viewModel.previousPage, '?page=1');
    });

    test('Feed data source by passing a empty page with mocked network',
        () async {
      viewModel.nextPage = '';
      viewModel.isNextPage = true;
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 4);
      expect(viewModel.isNextPage, isTrue);
      expect(viewModel.nextPage, '?page=2');
      expect(viewModel.previousPage, '?page=1');
    });

    test('Feed data source by searchName with real network', () async {
      viewModel.service = StarWarsServiceImpl();
      await viewModel.feedDataSource(searchCharacter: 'sky');
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 3);
    });

    test('Testing empty state with real network by searchName', () async {
      viewModel.service = StarWarsServiceImpl();
      await viewModel.feedDataSource(searchCharacter: 'cebolinha');
      expect(viewModel.loadingStatus, LoadingStatus.empty);
      expect(viewModel.dataSource.length, isZero);
    });

    //Although there are just 2 characters that contains the name with 'sky' on it
    //because the workaround in the scrolling with few items in the last screen
    //the result is 4.
    test('Feed data source by searchName with mocked network', () async {
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource(searchCharacter: 'sky');
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 4);
    });

    test('Testing error state with mocked network by searchName', () async {
      viewModel.service = MockedStarWarsService(state: MockedState.error);
      await viewModel.feedDataSource(searchCharacter: 'star trek');
      expect(viewModel.loadingStatus, LoadingStatus.error);
      expect(viewModel.dataSource.length, 0);
    });

    test('Testing empty state with mocked network by searchName', () async {
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource(searchCharacter: 'cebolinha');
      expect(viewModel.loadingStatus, LoadingStatus.empty);
      expect(viewModel.dataSource.length, 0);
    });
  });
}
