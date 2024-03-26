import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/constants/colors.dart';
import 'package:blog_app/core/utils/constants/image_strings.dart';
import 'package:blog_app/core/utils/functions/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  List<bool> selectedStates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNewBlogPage(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(
              context,
              "",
              "Something went wrong",
              TColors.failedBackgroundColor,
              TColors.failedAssetsColor,
              TImages.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }

          if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                bool isSelected = selectedStates.length > index
                    ? selectedStates[index]
                    : false;
                return Container(
                  color: Colors.grey.withOpacity(0.2),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.w),
                  child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          if (selectedStates.length <= index) {
                            selectedStates.add(true);
                          } else {
                            selectedStates[index] = true;
                          }
                        });
                      },
                      child: BlogCart(blog: blog)),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
