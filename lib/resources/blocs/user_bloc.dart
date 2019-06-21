import 'package:rxdart/rxdart.dart';
import '../../models/response/user_profile_response.dart';
import '../provider/user_provider.dart';
import '../../utils/const.dart';

class UserBloc {
  final userProvider = UserProvider();
  
  final _userInfoFetcher = PublishSubject<UserResponse>();
  Observable<UserResponse> get userInfoStream => _userInfoFetcher.stream;
  fecthUserInfo(int id) async {
    UserResponse userResponse = await userProvider.fetchUserDetail(id);
    username = userResponse.user.username;
    avatar = userResponse.user.avatar;
    _userInfoFetcher.sink.add(userResponse);
  }


  dispose() async {
    await _userInfoFetcher.drain();
    _userInfoFetcher.close();
  }

}

final userBloc = UserBloc();