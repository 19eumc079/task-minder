// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'expense_tracker_model.g.dart';

@HiveType(typeId: 1)
class ExpenseTrackerModel {
  @HiveField(0)
  String eName;
  @HiveField(1)
  String eDate;
  @HiveField(2)
  String eAmount;
  @HiveField(3)
  String eType;
  ExpenseTrackerModel({
    required this.eName,
    required this.eDate,
    required this.eAmount,
    required this.eType,
  });

  ExpenseTrackerModel copyWith({
    String? eName,
    String? eDate,
    String? eAmount,
    String? eType,
  }) {
    return ExpenseTrackerModel(
      eName: eName ?? this.eName,
      eDate: eDate ?? this.eDate,
      eAmount: eAmount ?? this.eAmount,
      eType: eType ?? this.eType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eName': eName,
      'eDate': eDate,
      'eAmount': eAmount,
      'eType': eType,
    };
  }

  factory ExpenseTrackerModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTrackerModel(
      eName: map['eName'] as String,
      eDate: map['eDate'] as String,
      eAmount: map['eAmount'] as String,
      eType: map['eType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseTrackerModel.fromJson(String source) =>
      ExpenseTrackerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExpenseTrackerModel(eName: $eName, eDate: $eDate, eAmount: $eAmount, eType: $eType)';
  }

  @override
  bool operator ==(covariant ExpenseTrackerModel other) {
    if (identical(this, other)) return true;

    return other.eName == eName &&
        other.eDate == eDate &&
        other.eAmount == eAmount &&
        other.eType == eType;
  }

  @override
  int get hashCode {
    return eName.hashCode ^ eDate.hashCode ^ eAmount.hashCode ^ eType.hashCode;
  }
}
