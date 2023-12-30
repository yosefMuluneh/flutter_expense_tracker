import 'dart:convert';
import 'dart:ffi';

class ExpenseDto {
  final int id;
  final int user_id;
  final String type;
  final String category;
  final double amount;
  final DateTime date;

  ExpenseDto(
      {this.id = 0,
      required this.user_id,
      required this.type,
      required this.category,
      required this.date,
      required this.amount});

  factory ExpenseDto.fromMap(Map<String, dynamic> map) {
    return ExpenseDto(
        id: map['id'],
        user_id: map['user_id'],
        type: map['type'],
        category: map['category'],
        date: DateTime.parse(map['date']),
        amount: map["amount"].toDouble());
  }

  toMap() {
    return {
      "id": id,
      "category": category,
      "date": date,
      "amount": amount,
      "user_id": user_id,
      "type": type,
    };
  }

  static List<ExpenseDto> fromList(List values) {
    return values.map((e) => ExpenseDto.fromMap(jsonDecode(e))).toList();
  }
}
