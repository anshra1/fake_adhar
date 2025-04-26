import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/routes/names.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/views/front_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FrontCover extends StatefulWidget {
  const FrontCover({super.key});

  @override
  State<FrontCover> createState() => _FrontCoverState();
}

class _FrontCoverState extends State<FrontCover> {
  @override
  void initState() {
    context.read<DocumentCubit>().getTheDocumentDate();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text(
          'Front Cover',
          style: context.textStyle.headlineLarge!.bold.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<DocumentCubit, DocumentState>(
        listener: (context, state) {
          if (state.failure != null && state.failure!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure!)),
            );
          } else if (state.isSuccess) {
            context.pushNamed(RoutesName.backCover);
          }
        },
        builder: (context, state) {
       
          if (state.loading) {
            return const Center(child: CircularProgressIndicator()); // Show loading
          } else {
            return FrontPageView(data: state.frontCover);
          }
        },
      ),
    );
  }
}
