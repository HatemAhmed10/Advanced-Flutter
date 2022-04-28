class WordModel {
  List<Word>? word;

  WordModel({this.word});

  WordModel.fromJson(Map<String, dynamic> json) {
    if (json['word'] != null) {
      word = <Word>[];
      json['word'].forEach((v) {
        word!.add(new Word.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.word != null) {
      data['word'] = this.word!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Word {
  String? sId;
  String? surahnumber;
  List<String>? words;
  int? iV;

  Word({this.sId, this.surahnumber, this.words, this.iV});

  Word.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    surahnumber = json['surahnumber'];
    words = json['words'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['surahnumber'] = this.surahnumber;
    data['words'] = this.words;
    data['__v'] = this.iV;
    return data;
  }
}