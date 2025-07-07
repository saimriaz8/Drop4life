class ProfilePageState {
  final int requestCount;
  final int donateCount;
  final bool isAvailbaleForDonate;

  ProfilePageState({this.donateCount = 0, this.requestCount = 0, this.isAvailbaleForDonate = false});

  ProfilePageState copyWith({int? donateCount, int? requestCount, bool? isAvailbaleForDonate}) {
    return ProfilePageState(
      donateCount: donateCount ?? this.donateCount,
      requestCount: requestCount ?? this.requestCount,
      isAvailbaleForDonate: isAvailbaleForDonate ?? this.isAvailbaleForDonate
    );
  }
}
