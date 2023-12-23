import 'dart:convert';
import 'package:http/http.dart' as http;
// http라고 패키지에 이름을 정해줌.
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  //API서버로부터 자료를 요청할 클래스 만들기.
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

// method 만들기.
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    //WebtoonModel의 객체(Instances)들로 구성된 리스트 'webtoonInstances'
    // 를 만들 겠다. 처음엔 비어있는 리스트이다.
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    // await 는 async function안에서만 사용 가능하다. (API 요청값이 올때까지 대기)
    // await해서 future에 받는 자료의 자료형은 Response이다.
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      // final webtoons = jsonDecode(response.body);
      // List<dynamic> 의 형태로 받게 될 것임. webtoons 앞에 적어도, 안적어도 무방.
      //response.body에는 API 서버가 보낸 데이터 값이 저장된다.
      // jsonDecode : 서버에서 받은 스트링 값(괄호 안)을 JSON형태로 바꿔준다.
      for (var webtoon in webtoons) {
        // webtoons라는 객체들로 이루어진 리스트의 각 객체 별로 다음을 실행.
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        // 이렇게 정리도 가능 : final instance = WebtoonMode.fromJson(webtoon);
        // webtoonInstances.add(instance)
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
