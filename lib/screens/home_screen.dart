import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

/*(초보 방식)비추다. 왜냐하면 작성할 코드도 많고 HomeScreen이 Stateful
  위젯이어야하기때문.
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async{
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState((){});
  }   

  @override
  void initState(){
    super.initState();
    waitForWebToons
  }
 */
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
  // 웹툰모델 인스턴스로 구성된 리스트를 미래에 가져올 때 웹툰스 변수에 넣을 것이다.
  // 이는 Apiservice.getTodaysToons()로부터 온다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Text(
          "Webtoon of the day",
          style: TextStyle(
            fontSize: 24,
            // fontWeight: FontWeight.bold,
            fontFamily: 'NotoSans',
            // fontFamily: 'Roboto',
            // fontFamily: 'Cupertino',
          ),
          // 폰트 바꾸는 방법은?
        ),
      ),
      // Future값을 불러오는 것을 기다려주는 위젯 : FutureBuilder.
      //Builder : Widget for drawing the UI.
      body: FutureBuilder(
        future: webtoons,
        // Wait for the future called 'webtoons'
        builder: (context, snapshot) {
          // If you use 'snapshot', you can see the statue of future.
          if (snapshot.hasData) {
            return Column(children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(child: makeList(snapshot))
            ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        // print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 50,
      ),
      // itembuilder는 필요한 만큼의 리스트 목록만 로드한다.
    );
  }
}
