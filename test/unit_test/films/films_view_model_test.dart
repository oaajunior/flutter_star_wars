import 'package:app_star_wars/models/films/films_model.dart';
import 'package:app_star_wars/utils/loading_status.dart';
import 'package:test/test.dart';
import 'package:app_star_wars/services/starwars_service.dart';
import 'package:app_star_wars/view_model/films/films_view_model.dart';
import '../../helper/services/mocked_starwars_service.dart';

main() {
  group('Test FilmsViewModel', () {
    FilmsViewModel viewModel;

    setUpAll(() {
      viewModel = FilmsViewModel();
    });

    test('Initial state', () {
      expect(viewModel.dataSource.length, isZero);
      expect(viewModel.service, isNotNull);
    });

    test('Feed data source with real network', () async {
      expect(viewModel.loadingStatus, LoadingStatus.loading);
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 6);
    });

    test('Feed data source with mocked network', () async {
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 3);
    });

    test('Testing loading state with mocked network', () {
      viewModel = FilmsViewModel();
      viewModel.service = MockedStarWarsService();
      viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.loading);
    });

    test('Testing error state with mocked network', () async {
      viewModel.service = MockedStarWarsService(state: MockedState.error);
      await viewModel.feedDataSource();
      expect(viewModel.loadingStatus, LoadingStatus.error);
    });

    test('Feed data source by searchName with real network', () async {
      viewModel.service = StarWarsServiceImpl();
      await viewModel.feedDataSource(searchName: 'revenge');
      expect(viewModel.loadingStatus, LoadingStatus.completed);
      expect(viewModel.dataSource.length, 1);
    });

    test('Testing error state with mocked network by searchName', () async {
      viewModel.service = MockedStarWarsService(state: MockedState.error);
      await viewModel.feedDataSource(searchName: 'star trek');
      expect(viewModel.loadingStatus, LoadingStatus.error);
      expect(viewModel.dataSource.length, 0);
    });

    test('Testing empty state with mocked network by searchName', () async {
      viewModel.service = MockedStarWarsService();
      await viewModel.feedDataSource(searchName: 'nothing to search');
      expect(viewModel.loadingStatus, LoadingStatus.empty);
      expect(viewModel.dataSource.length, 0);
    });

    test('Testing orderListFilms function, passing a null value', () {
      List<FilmsModel> listFilms;
      viewModel.orderListFilms(listFilms);
      expect(listFilms, isNull);
    });

     test('Testing orderListFilms function with a empty list', () {
      List<FilmsModel> listFilms =[];
     
      viewModel.orderListFilms(listFilms);
      expect(listFilms, isEmpty);
    });

     test('Testing orderListFilms function', () {
      List<FilmsModel> listFilms =[];
      FilmsModel film1 = FilmsModel();
      FilmsModel film2 = FilmsModel();
      FilmsModel film3 = FilmsModel();
      film1.episodeId = 2;
      film2.episodeId = 1;
      film3.episodeId = 4;
      listFilms.add(film1);
      listFilms.add(film2);
      listFilms.add(film3);
      viewModel.orderListFilms(listFilms);
      expect(listFilms, equals([film2, film1, film3]));
    });
  });
}
