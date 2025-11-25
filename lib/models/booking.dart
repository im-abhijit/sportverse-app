import 'venue.dart';
import 'slot.dart';

class Booking {
  final int id;
  final String date;
  final double amount;
  final String bookingStatus;
  final String paymentStatus;
  final Venue? venue;
  final List<Slot>? slots;

  Booking({
    required this.id,
    required this.date,
    required this.amount,
    required this.bookingStatus,
    required this.paymentStatus,
    this.venue,
    this.slots,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      bookingStatus: json['bookingStatus'] as String? ?? 'INITIATED',
      paymentStatus: json['paymentStatus'] as String? ?? 'PENDING',
      venue: json['venue'] != null
          ? Venue.fromJson(json['venue'] as Map<String, dynamic>)
          : null,
      slots: json['slots'] != null
          ? (json['slots'] as List)
              .map((slot) => Slot.fromJson(slot as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'bookingStatus': bookingStatus,
      'paymentStatus': paymentStatus,
      'venue': venue?.toJson(),
      'slots': slots?.map((slot) => slot.toJson()).toList(),
    };
  }

  String get slotsTimeDisplay {
    if (slots == null || slots!.isEmpty) return 'No slots';
    final firstSlot = slots!.first;
    final lastSlot = slots!.last;
    return '${firstSlot.startTime} - ${lastSlot.endTime}';
  }
}

