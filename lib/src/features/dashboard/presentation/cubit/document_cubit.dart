import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_adhar/src/features/dashboard/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(const DocumentState());
  // say your problem

  Future<void> getTheDocumentDate() {
    return Future.value();
  }

  Future<void> updateTheDocumentData({
    FrontCoverEntity? frontCover,
    BackCoverEntity? backCover,
    bool isSuccess = false,
  
  }) async {
    final data = state.copyWith(
      frontCover: frontCover,
      backCover: backCover,
      loading: false,
      isSuccess: isSuccess,
      failure: '',
    );
    emit(data);
  }
}
