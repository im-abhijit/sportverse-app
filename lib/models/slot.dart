class Slot {
  final int slotId;
  final String startTime;
  final String endTime;
  final double price;
  final bool booked;
  final String? date;

  Slot({
    required this.slotId,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.booked,
    this.date,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      slotId: json['slotId'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      price: (json['price'] as num).toDouble(),
      booked: json['booked'] as bool? ?? false,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'booked': booked,
      'date': date,
    };
  }

  String get timeDisplay => '$startTime - $endTime';
}

