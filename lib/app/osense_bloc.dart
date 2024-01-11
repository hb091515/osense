import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osense_test/app/osense_event.dart';
import 'package:osense_test/app/osense_state.dart';

class OsenseBloc extends Bloc<OsenseEvent, OsenseState> {
  OsenseBloc(super.initialState) {
    on<OsenseSubmit>(submit);
  }

  void submit(
    OsenseSubmit event,
    Emitter<OsenseState> emit,
  ) async {
    emit.call(state.copyWith(
      status: OsensePageStatus.submitSuccess,
      name: event.name,
      selectFruit: event.selectFruit,
    ));
  }
}
