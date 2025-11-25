class Venue {
  final int id;
  final String name;
  final String? address;
  final String? addtress; // API typo
  final String? city;
  final String? description;
  final List<String>? photos;
  final List<String>? games;
  final String? partnerMobileNo;
  final int? partnerId;

  Venue({
    required this.id,
    required this.name,
    this.address,
    this.addtress,
    this.city,
    this.description,
    this.photos,
    this.games,
    this.partnerMobileNo,
    this.partnerId,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      address: json['address'] as String?,
      addtress: json['addtress'] as String?,
      city: json['city'] as String?,
      description: json['description'] as String?,
      photos: json['photos'] != null
          ? List<String>.from(json['photos'] as List)
          : null,
      games: json['games'] != null
          ? List<String>.from(json['games'] as List)
          : null,
      partnerMobileNo: json['partnerMobileNo'] as String?,
      partnerId: json['partnerId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address ?? addtress,
      'city': city,
      'description': description,
      'photos': photos,
      'games': games,
      'partnerMobileNo': partnerMobileNo,
      'partnerId': partnerId,
    };
  }

  String get displayAddress => address ?? addtress ?? 'Address not available';
}

