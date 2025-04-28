import 'dart:io';

import 'package:equatable/equatable.dart';

class FrontCoverEntity extends Equatable {
  const FrontCoverEntity({
    this.fullName = 'r',
    this.aadhaarNumber = '',
    this.dateOfBirth = '',
    this.gender = 'Male',
    this.file,
    this.uuid,
  });

  final String fullName;
  final String aadhaarNumber;
  final String dateOfBirth;
  final String gender;
  final File? file;
  final String? uuid;

  // CopyWith method to create a new instance with updated values
  FrontCoverEntity copyWith({
    String? fullName,
    String? aadhaarNumber,
    String? dateOfBirth,
    String? gender,
    File? file,
    String? uuid,
  }) {
    return FrontCoverEntity(
      fullName: fullName ?? this.fullName,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      file: file ?? this.file,
      uuid: uuid ?? this.uuid,
    );
  }

  @override
  String toString() {
    return 'FrontCoverEntity(fullName: $fullName, aadhaarNumber: $aadhaarNumber, dateOfBirth: $dateOfBirth, gender: $gender, file: $file)';
  }

  @override
  List<Object?> get props => [fullName, aadhaarNumber, dateOfBirth, gender, file, uuid];
}

class BackCoverEntity extends Equatable {
  const BackCoverEntity({
    required this.fatherName,
    required this.vidNo,
    required this.wardNo,
    required this.localAddress,
    required this.subDistrict,
    required this.po,
    required this.district,
    required this.state,
    required this.pinCode,
    this.uuid,
  });
  
  final String fatherName;
  final String vidNo;
  final String wardNo;
  final String localAddress;
  final String subDistrict;
  final String po;
  final String district;
  final String state;
  final String pinCode;
  final String? uuid;

  BackCoverEntity copyWith({
    String? fatherName,
    String? vidNo,
    String? wardNo,
    String? localAddress,
    String? subDistrict,
    String? po,
    String? district,
    String? state,
    String? pinCode,
  }) {
    return BackCoverEntity(
      fatherName: fatherName ?? this.fatherName,
      vidNo: vidNo ?? this.vidNo,
      wardNo: wardNo ?? this.wardNo,
      localAddress: localAddress ?? this.localAddress,
      subDistrict: subDistrict ?? this.subDistrict,
      po: po ?? this.po,
      district: district ?? this.district,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  @override
  List<Object?> get props => [
        fatherName,
        vidNo,
        wardNo,
        localAddress,
        po,
        subDistrict,
        district,
        state,
        pinCode,
        uuid,
      ];
}
