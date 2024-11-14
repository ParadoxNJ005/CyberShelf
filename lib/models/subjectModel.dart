class Subject {
  String? id;
  String? subjectCode;
  List<QuestionPaper>? questionPapers;
  List<Moderator>? moderators;
  List<RecommendedBook>? recommendedBooks;
  List<Material>? materials;
  List<ImportantLink>? importantLinks;

  Subject({
    this.id,
    this.subjectCode,
    this.questionPapers,
    this.moderators,
    this.recommendedBooks,
    this.materials,
    this.importantLinks,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'] as String?,
      subjectCode: json['SubjectCode'] as String?,
      questionPapers: (json['QuestionPapers'] as List<dynamic>?)
          ?.map((e) => QuestionPaper.fromJson(e as Map<String, dynamic>))
          .toList(),
      moderators: (json['MODERATORS'] as List<dynamic>?)
          ?.map((e) => Moderator.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedBooks: (json['Recommended Books'] as List<dynamic>?)
          ?.map((e) => RecommendedBook.fromJson(e as Map<String, dynamic>))
          .toList(),
      materials: (json['Material'] as List<dynamic>?)
          ?.map((e) => Material.fromJson(e as Map<String, dynamic>))
          .toList(),
      importantLinks: (json['Important Links'] as List<dynamic>?)
          ?.map((e) => ImportantLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'SubjectCode': subjectCode,
      'QuestionPapers': questionPapers?.map((e) => e.toJson()).toList(),
      'MODERATORS': moderators?.map((e) => e.toJson()).toList(),
      'Recommended Books': recommendedBooks?.map((e) => e.toJson()).toList(),
      'Material': materials?.map((e) => e.toJson()).toList(),
      'Important Links': importantLinks?.map((e) => e.toJson()).toList(),
    };
  }
}

class QuestionPaper {
  String? id;
  String? type;
  String? year;
  String? title;
  String? url;

  QuestionPaper({this.id, this.type, this.year, this.title, this.url});

  factory QuestionPaper.fromJson(Map<String, dynamic> json) {
    return QuestionPaper(
      id: json['_id'] as String?,
      type: json['Type'] as String?,
      year: json['Year'] as String?,
      title: json['Title'] as String?,
      url: json['URL'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Type': type,
      'Year': year,
      'Title': title,
      'URL': url,
    };
  }
}

class Moderator {
  String? id;
  String? contactNumber;
  String? uid;
  String? name;

  Moderator({this.id, this.contactNumber, this.uid, this.name});

  factory Moderator.fromJson(Map<String, dynamic> json) {
    return Moderator(
      id: json['_id'] as String?,
      contactNumber: json['Contact Number'] as String?,
      uid: json['uid'] as String?,
      name: json['Name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Contact Number': contactNumber,
      'uid': uid,
      'Name': name,
    };
  }
}

class RecommendedBook {
  String? id;
  String? publication;
  String? author;
  String? bookTitle;

  RecommendedBook({this.id, this.publication, this.author, this.bookTitle});

  factory RecommendedBook.fromJson(Map<String, dynamic> json) {
    return RecommendedBook(
      id: json['_id'] as String?,
      publication: json['Publication'] as String?,
      author: json['Author'] as String?,
      bookTitle: json['BookTitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Publication': publication,
      'Author': author,
      'BookTitle': bookTitle,
    };
  }
}

class Material {
  String? id;
  String? contentUrl;
  String? title;

  Material({this.id, this.contentUrl, this.title});

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['_id'] as String?,
      contentUrl: json['Content URL'] as String?,
      title: json['Title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Content URL': contentUrl,
      'Title': title,
    };
  }
}

class ImportantLink {
  String? id;
  String? contentUrl;
  String? title;

  ImportantLink({this.id, this.contentUrl, this.title});

  factory ImportantLink.fromJson(Map<String, dynamic> json) {
    return ImportantLink(
      id: json['_id'] as String?,
      contentUrl: json['Content URL'] as String?,
      title: json['Title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Content URL': contentUrl,
      'Title': title,
    };
  }
}
