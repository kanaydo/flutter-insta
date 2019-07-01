import '../provider/post_provider.dart';
import '../../models/response/post_response.dart';
import '../../models/response/feed_response.dart';
import '../../models/response/post/show.dart';
import '../../models/response/post/explore.dart';
import '../../models/response/post/comment_detail.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc {

  final postProvider = PostProvider();
  
  final _userPostsFetcher = PublishSubject<PostResponse>();
  Observable<PostResponse> get userPostsStream => _userPostsFetcher.stream;
  fecthUserPosts(int id) async {
    PostResponse postResponse = await postProvider.fetchUserPosts(id);
    _userPostsFetcher.sink.add(postResponse);
  }

  final _feedFetcher = PublishSubject<FeedResponse>();
  Observable<FeedResponse> get feedStream => _feedFetcher.stream;
  fetchUserFeed(int id) async {
    FeedResponse feedResponse = await postProvider.fecthFeeds(id);
    _feedFetcher.sink.add(feedResponse);
  }

  final _postDetailsFecther = PublishSubject<ShowPostResponse>();
  Observable<ShowPostResponse> get postDetailsStream => _postDetailsFecther.stream;
  fetchPostDetails(int postId) async {
    ShowPostResponse showPostResponse = await postProvider.fetchPostDetails(postId);
    _postDetailsFecther.sink.add(showPostResponse);
  }

  final _explorePostFetcher = PublishSubject<ExploreResponse>();
  Observable<ExploreResponse> get explorePostStream => _explorePostFetcher.stream;
  fetchExplorePost() async {
    ExploreResponse exploreResponse = await postProvider.fetchPostExplore();
    _explorePostFetcher.sink.add(exploreResponse);
  }

  final _postCommentsFecther = PublishSubject<PostCommentsResponse>();
  Observable<PostCommentsResponse> get postCommentsStream => _postCommentsFecther.stream;
  fetchPostComments(int postId) async {
    PostCommentsResponse postCommentsResponse = await postProvider.fecthPostComments(postId);
    _postCommentsFecther.sink.add(postCommentsResponse);
  }

  dispose() async {
    await _userPostsFetcher.drain();
    _userPostsFetcher.close();
    await _feedFetcher.drain();
    _feedFetcher.close();
    await _postDetailsFecther.drain();
    _postDetailsFecther.close();
    await _explorePostFetcher.drain();
    _explorePostFetcher.close();
    await _postCommentsFecther.drain();
    _postCommentsFecther.close();
  }

}

final postBloc = PostBloc();