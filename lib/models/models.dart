class Comic {
  final String id;
  final String name;
  final String genre;
  final String image;

  Comic({
    required this.id,
    required this.name,
    required this.genre,
    required this.image,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id_comic'].toString(),
      name: json['name_c'],
      genre: json['genre'],
      image: json['image'],
    );
  }
}

class Detail {
  final String status;
  final String description;

  Detail({
    required this.status,
    required this.description,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      status: json['status'],
      description: json['description'],
    );
  }
}

class Subbutton {
  final String idsub;
  final String name;
  final String namesub;

  Subbutton({
    required this.idsub,
    required this.name,
    required this.namesub,
  });

  factory Subbutton.fromJson(Map<String, dynamic> json) {
    return Subbutton(
      idsub: json['id_sub'].toString(),
      name: json['name'],
      namesub: json['name_sub'],
    );
  }
}

class Sbimages {
  final String idimages;
  final String images;

  Sbimages({
    required this.idimages,
    required this.images,
  });

  factory Sbimages.fromJson(Map<String, dynamic> json) {
    return Sbimages(
      idimages: json['id_image'].toString(),
      images: json['images'],
    );
  }
}

