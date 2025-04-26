part of 'document_cubit.dart';

@immutable
class DocumentState extends Equatable {
  const DocumentState({
    this.frontCover,
    this.backCover,
    this.loading = false,
    this.isSuccess = false,
    this.failure,
  });

  final FrontCoverEntity? frontCover;
  final BackCoverEntity? backCover;
  final bool loading;
  final bool isSuccess;
  final String? failure;
  

  DocumentState copyWith({
    FrontCoverEntity? frontCover,
    BackCoverEntity? backCover,
    bool? loading,
    bool? isSuccess,
    String? failure,
  }) {
    return DocumentState(
      frontCover: frontCover ?? this.frontCover,
      backCover: backCover ?? this.backCover,
      loading: loading ?? this.loading,
      isSuccess: isSuccess ?? this.isSuccess,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        frontCover,
        backCover,
        loading,
        isSuccess,
        failure,
      ];
}
