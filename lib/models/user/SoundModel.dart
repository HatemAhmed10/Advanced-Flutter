class SoundModel {
  List<Sound>? sound;

  SoundModel({this.sound});

  SoundModel.fromJson(Map<String, dynamic> json) {
    if (json['sound'] != null) {
      sound = <Sound>[];
      json['sound'].forEach((v) {
        sound!.add(new Sound.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sound != null) {
      data['sound'] = this.sound!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sound {
  String? sId;
  String? surahnumber;
  String? wordnumber;
  List<String>? sounds;
  int? iV;

  Sound({this.sId, this.surahnumber, this.wordnumber, this.sounds, this.iV});

  Sound.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    surahnumber = json['surahnumber'];
    wordnumber = json['wordnumber'];
    sounds = json['sounds'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['surahnumber'] = this.surahnumber;
    data['wordnumber'] = this.wordnumber;
    data['sounds'] = this.sounds;
    data['__v'] = this.iV;
    return data;
  }
}