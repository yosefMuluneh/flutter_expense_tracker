import 'dart:convert';
import 'dart:ffi';

class BudgetDto {
  final int id;
  final int user_id;
  final String type;
  final double amount;
  final DateTime date;
  double expense;
  double income;

  BudgetDto(
      {this.id = 0,
      required this.user_id,
      required this.type,
      required this.date,
      required this.amount,
      this.expense = 0,
      this.income = 0});

  factory BudgetDto.fromMap(Map<String, dynamic> map) {
    return BudgetDto(
        id: map['id'],
        user_id: map['user_id'],
        type: map['type'],
        date: DateTime.parse(map['date']),
        amount: map["amount"].toDouble());
  }

  toMap() {
    return {
      "id": id,
      "date": date,
      "amount": amount,
      "user_id": user_id,
      "type": type,
    };
  }

  static List<BudgetDto> fromList(List values) {
    return values.map((e) => BudgetDto.fromMap(jsonDecode(e))).toList();
  }
}
