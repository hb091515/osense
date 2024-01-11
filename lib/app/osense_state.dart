import 'package:equatable/equatable.dart';

class OsenseState extends Equatable {
  final OsensePageStatus status;

  final String? name;

  final String? dropDownSelect;

  final String? selectFruit;
  OsenseState.initState()
      : this._(
          status: OsensePageStatus.idle,
          name: "",
          dropDownSelect: "",
          selectFruit: "",
        );
  OsenseState copyWith({
    OsensePageStatus? status,
    String? name,
    String? dropDownSelect,
    String? selectFruit,
  }) =>
      OsenseState._(
          status: status ?? this.status,
          name: name ?? this.name,
          dropDownSelect: dropDownSelect ?? this.dropDownSelect,
          selectFruit: selectFruit ?? this.selectFruit);

  OsenseState._({
    required this.status,
    this.name,
    this.dropDownSelect,
    this.selectFruit,
  });

  @override
  List<Object?> get props => [
        status,
        name,
        dropDownSelect,
        selectFruit,
      ];
}

enum OsensePageStatus {
  idle,
  submitSuccess,
}
