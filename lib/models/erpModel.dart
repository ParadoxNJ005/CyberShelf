class Erp {
  String? name;
  String? email;
  String? no;
  String? cgpa;
  String? sem1;
  String? sem2;
  String? sem3;
  String? sem4;
  String? sem5;
  String? sem6;
  String? sem7;
  String? sem8;

  Erp({this.name, this.email, this.no, this.cgpa, this.sem1, this.sem2, this.sem3, this.sem4, this.sem5, this.sem6, this.sem7, this.sem8});

  Erp.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    no = json["No"];
    cgpa = json["CGPA"];
    sem1 = json["sem1"];
    sem2 = json["sem2"];
    sem3 = json["sem3"];
    sem4 = json["sem4"];
    sem5 = json["sem5"];
    sem6 = json["sem6"];
    sem7 = json["sem7"];
    sem8 = json["sem8"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["email"] = email;
    _data["No"] = no;
    _data["CGPA"] = cgpa;
    _data["sem1"] = sem1;
    _data["sem2"] = sem2;
    _data["sem3"] = sem3;
    _data["sem4"] = sem4;
    _data["sem5"] = sem5;
    _data["sem6"] = sem6;
    _data["sem7"] = sem7;
    _data["sem8"] = sem8;
    return _data;
  }
}