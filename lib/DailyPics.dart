class DailyPics {
  List<String> result;

  DailyPics({this.result});

  DailyPics.fromJson(Map<String, dynamic> json) {
    result = json['result'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}

class DailyPics2 {
  List<String> results;

  DailyPics2({this.results});

  DailyPics2.fromJson(Map<String, dynamic> json) {
    results = json['results'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    return data;
  }
}
