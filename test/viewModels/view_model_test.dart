import 'package:flutter_test/flutter_test.dart';
import 'package:games_deal_tracking/data/repositories/deals_remote_data_repo_impl.dart';
import 'package:games_deal_tracking/data/services/api_service.dart';
import 'package:games_deal_tracking/viewModel/home_view_model.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ApiService,DealsRemoteDataRepoImpl])
void main() {
  group('HomeViewModel', () {
    final ApiService apiService = ApiService();
    final mockDealsRemoteDataRepoImpl = DealsRemoteDataRepoImpl(apiService);
    test('Initial state should be loading', () {
      final viewModel = HomeViewModel(mockDealsRemoteDataRepoImpl);
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, '');
    });

    test('Fetch deals should update state correctly', () async {
      final viewModel = HomeViewModel(mockDealsRemoteDataRepoImpl);
      viewModel.fetchDeals();
      expect(viewModel.isLoading, true);
      expect(viewModel.errorMessage, null);
    });

    test('error message should be null', () async {
      final viewModel = HomeViewModel(mockDealsRemoteDataRepoImpl);
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, '');
    });

    test("fetchDealsByTitle should update state correctly", () async {
      final viewModel = HomeViewModel(mockDealsRemoteDataRepoImpl);
      viewModel.fetchDealsByTitle("test");
      expect(viewModel.isLoading, true);
      expect(viewModel.errorMessage, null);
    });
  });
}
