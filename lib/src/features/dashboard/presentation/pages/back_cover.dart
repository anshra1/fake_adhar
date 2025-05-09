import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/routes/names.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/views/back_cover_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BackCover extends StatefulWidget {
  const BackCover({super.key});

  @override
  State<BackCover> createState() => _BackCoverState();
}

class _BackCoverState extends State<BackCover> {
  @override
  void initState() {
    // Fetch document data when the widget initializes
    context.read<DocumentCubit>().getTheDocumentDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.go(RoutesName.frontCover);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Back Cover',
            style: context.textStyle.headlineLarge!.bold.copyWith(color: Colors.white),
          ),
        ),
        body: BlocConsumer<DocumentCubit, DocumentState>(
          listener: (context, state) {
            // Handle side effects (e.g., show snackbar on error)
            if (state.failure != null && state.failure!.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure!)),
              );
            } else if (state.isSuccess) {
              context.pushNamed(RoutesName.adhaarBuildPage);
            }
          },
          builder: (context, state) {
          
            if (state.loading) {
              return const Center(child: CircularProgressIndicator()); // Show loading
            } else if (state.frontCover != null) {
              return BackCoverPageView(data: state); // Pass data to the view
            } else {
              return const Center(child: Text('No data available')); // Handle empty state
            }
          },
        ),
      ),
    );
  }
}
