import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState>{
    DashboardCubit(): super(const DashboardState());


    void setTab(DashboardTab tab ) => emit(DashboardState(tab: tab));
}