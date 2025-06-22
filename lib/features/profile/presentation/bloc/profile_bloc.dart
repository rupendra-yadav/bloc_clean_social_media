import 'package:clean_bloc_wrap/features/profile/domain/entity/profile_entity.dart';
import 'package:clean_bloc_wrap/features/profile/domain/use_cases/follow_toggle.dart';
import 'package:clean_bloc_wrap/features/profile/domain/use_cases/get_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FollowToggleUseCase followToggleUseCase;
  final GetDataUseCase getDataUseCase;
  ProfileBloc({required this.followToggleUseCase, required this.getDataUseCase})
    : super(ProfileInitial()) {
    on<ProfileFollowToggle>(_followToggle);
    on<ProfileGetData>(_getData);
  }
  void _followToggle(ProfileFollowToggle event, Emitter emit) async {
    try {
      final result = await followToggleUseCase(
        FollowToggleParams(event.currentId, event.targetId),
      );
      result.fold((failure) => emit(ProfileError()), (_) => {});
      // ProfileGetData(event.targetId);
    } catch (e) {
      emit(ProfileError());
    }
  }

  void _getData(ProfileGetData event, Emitter emit) async {
    try {
      emit(ProfileLoading());
      final result = await getDataUseCase(GetDataParams(event.uid));
      result.fold(
        (failure) => emit(ProfileError()),
        (user) => emit(ProfileLoaded(user)),
      );
    } catch (e) {
      emit(ProfileError());
    }
  }
}
