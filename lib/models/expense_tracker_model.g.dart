// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_tracker_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseTrackerModelAdapter extends TypeAdapter<ExpenseTrackerModel> {
  @override
  final int typeId = 1;

  @override
  ExpenseTrackerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseTrackerModel(
      eName: fields[0] as String,
      eDate: fields[1] as String,
      eAmount: fields[2] as String,
      eType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseTrackerModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.eName)
      ..writeByte(1)
      ..write(obj.eDate)
      ..writeByte(2)
      ..write(obj.eAmount)
      ..writeByte(3)
      ..write(obj.eType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTrackerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
