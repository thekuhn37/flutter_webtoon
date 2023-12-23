/*class WebtoonModel {
  late final String title, thumb, id;

  WebtoonModel(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    id = json['id'];
  }
}
*/

// Named Constructor 표현 방식
class WebtoonModel {
  final String title, thumb, id;
  //스트링 타입의 property 세개를 선언.

  // named constructor (클래스이름 + '.' + 명명한 이름(fromJson) +
  //(함수 호출 시 argument로 받게 될 값은 Map 형식임.
  //Map의 <Key의 자료형, Value자료형> 명명한 이름 ))
  // 이렇게 받은 argument를 이용하여  WebtoonModel의 각각의 Property를
  // 초기화할 것을 규정.(전달받은 argument의 무엇을 초기화에 쓸지 명시))
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
