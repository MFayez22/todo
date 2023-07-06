abstract class HomeState {}

class HomeInitialState extends HomeState{}

class HomeLoadingState extends HomeState{}

/// splash Screen

class SplashMoveSuccessState extends HomeState{}

/// BottomNavigationBar

class BottomNavigationBarIndexChange extends HomeState{}

/// time
class GetDateTimeState extends HomeState{}

class ChooseYearState extends HomeState{}


/// database

class AddTaskListLoadingState extends HomeState{}
class AddTaskListSuccessState extends HomeState{}

class GetTaskListLoadingState extends HomeState{}
class GetTaskListSuccessState extends HomeState{}

class GetTodayTaskListLoadingState extends HomeState{}
class GetTodayTaskListSuccessState extends HomeState{}


class UpdateTaskSuccessState extends HomeState{}

class DoneTaskSuccessState extends HomeState{}
class GetDoneListSuccessState extends HomeState{}
class DeleteDoneSuccessState extends HomeState{}


class AddNoteSuccessState extends HomeState{}
class UpdateNoteSuccessState extends HomeState{}



class ChooseLevelOfImportant extends HomeState{}
class ChooseTime extends HomeState{}
class ChooseDate extends HomeState{}

class GetDateTaskListSuccessState extends HomeState{}

class GetMonthDateTaskListSuccessState extends HomeState{}

class DeleteTaskListSuccessState extends HomeState{}

class GetSearchListSuccessState extends HomeState{}


/// Container Visibility
class ContainerVisibilitySuccessState extends HomeState{}


class SwitchValueChangeState extends HomeState{}
class SaveLanguageSuccessState extends HomeState{}