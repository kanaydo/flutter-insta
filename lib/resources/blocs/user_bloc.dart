import 'package:rxdart/rxdart.dart';
import '../../models/response/user_profile_response.dart';
import '../../models/response/user/relation_response.dart';
import '../provider/user_provider.dart';

class UserBloc {
  final userProvider = UserProvider();
  
  final _userInfoFetcher = PublishSubject<UserResponse>();
  Observable<UserResponse> get userInfoStream => _userInfoFetcher.stream;
  fecthUserInfo(int id) async {
    UserResponse userResponse = await userProvider.fetchUserDetail(id);
    _userInfoFetcher.sink.add(userResponse);
  }


  final _userFollowersFetcher = PublishSubject<RelationResponse>();
  Observable<RelationResponse> get userFollowersStream => _userFollowersFetcher.stream;
  fetchUserFollowers(int userId) async {
    RelationResponse relationResponse = await userProvider.fecthUserFollowers(userId);
    _userFollowersFetcher.sink.add(relationResponse);
  }

  final _userFollowingFetcher = PublishSubject<RelationResponse>();
  Observable<RelationResponse> get userFollowingStream => _userFollowersFetcher.stream;
  fetchUserFollowing(int userId) async {
    RelationResponse relationResponse = await userProvider.fecthUserFollowing(userId);
    _userFollowingFetcher.sink.add(relationResponse);
  }


  dispose() async {
    await _userInfoFetcher.drain();
    _userInfoFetcher.close();
    await _userFollowersFetcher.drain();
    _userFollowersFetcher.close();
    await _userFollowingFetcher.drain();
    _userFollowingFetcher.close();
  }

}

final userBloc = UserBloc();