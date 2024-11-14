class SpecificSubject {
  List<Sub>? sub;

  SpecificSubject({this.sub});

  SpecificSubject.fromJson(Map<String, dynamic> json) {
    sub = json["sub"] == null ? null : (json["sub"] as List).map((e) => Sub.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sub != null) data["sub"] = sub?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Sub {
  String? id;
  String? subjectCode;
  List<QuestionPapers>? questionPapers;
  List<Moderators>? moderators;
  List<RecommendedBooks>? recommendedBooks;
  List<Material>? material;
  List<ImportantLinks>? importantLinks;

  Sub({
    this.id,
    this.subjectCode,
    this.questionPapers,
    this.moderators,
    this.recommendedBooks,
    this.material,
    this.importantLinks,
  });

  Sub.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    subjectCode = json["SubjectCode"];
    questionPapers = json["QuestionPapers"] == null
        ? null
        : (json["QuestionPapers"] as List).map((e) => QuestionPapers.fromJson(e)).toList();
    moderators = json["MODERATORS"] == null
        ? null
        : (json["MODERATORS"] as List).map((e) => Moderators.fromJson(e)).toList();
    recommendedBooks = json["Recommended Books"] == null
        ? null
        : (json["Recommended Books"] as List).map((e) => RecommendedBooks.fromJson(e)).toList();
    material = json["Material"] == null
        ? null
        : (json["Material"] as List).map((e) => Material.fromJson(e)).toList();
    importantLinks = json["Important Links"] == null
        ? null
        : (json["Important Links"] as List).map((e) => ImportantLinks.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["SubjectCode"] = subjectCode;
    if (questionPapers != null) data["QuestionPapers"] = questionPapers?.map((e) => e.toJson()).toList();
    if (moderators != null) data["MODERATORS"] = moderators?.map((e) => e.toJson()).toList();
    if (recommendedBooks != null) data["Recommended Books"] = recommendedBooks?.map((e) => e.toJson()).toList();
    if (material != null) data["Material"] = material?.map((e) => e.toJson()).toList();
    if (importantLinks != null) data["Important Links"] = importantLinks?.map((e) => e.toJson()).toList();
    return data;
  }
}

class ImportantLinks {
  String? id;
  String? contentUrl;
  String? title;

  ImportantLinks({this.id, this.contentUrl, this.title});

  ImportantLinks.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    contentUrl = json["Content URL"];
    title = json["Title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["Content URL"] = contentUrl;
    data["Title"] = title;
    return data;
  }
}

class Material {
  String? id;
  String? contentUrl;
  String? title;

  Material({this.id, this.contentUrl, this.title});

  Material.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    contentUrl = json["Content URL"];
    title = json["Title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["Content URL"] = contentUrl;
    data["Title"] = title;
    return data;
  }
}

class RecommendedBooks {
  String? id;
  String? publication;
  String? author;
  String? bookTitle;

  RecommendedBooks({this.id, this.publication, this.author, this.bookTitle});

  RecommendedBooks.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    publication = json["Publication"];
    author = json["Author"];
    bookTitle = json["BookTitle"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["Publication"] = publication;
    data["Author"] = author;
    data["BookTitle"] = bookTitle;
    return data;
  }
}

class Moderators {
  String? id;
  String? contactNumber;
  String? uid;
  String? name;

  Moderators({this.id, this.contactNumber, this.uid, this.name});

  Moderators.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    contactNumber = json["Contact Number"];
    uid = json["uid"];
    name = json["Name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["Contact Number"] = contactNumber;
    data["uid"] = uid;
    data["Name"] = name;
    return data;
  }
}

class QuestionPapers {
  String? id;
  String? type;
  String? year;
  String? title;
  String? url;

  QuestionPapers({this.id, this.type, this.year, this.title, this.url});

  QuestionPapers.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    type = json["Type"];
    year = json["Year"];
    title = json["Title"];
    url = json["URL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["Type"] = type;
    data["Year"] = year;
    data["Title"] = title;
    data["URL"] = url;
    return data;
  }
}
