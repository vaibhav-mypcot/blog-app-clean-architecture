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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
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
        List<int> selectedIndices = state is BlogDisplaySuccess
            ? (state).selectedIndices.keys.toList()
            : [];
        if (state is BlogLoading) {
          return const Loader();
        }

        if (state is BlogDisplaySuccess) {
          bool isEmptyBox = selectedIndices.isEmpty ? true : false;
          return Scaffold(
            appBar: AppBar(
              title: isEmptyBox ? const Text('Blog App') : null,
              leading: isEmptyBox
                  ? null
                  : IconButton(
                      onPressed: () {
                        BlocProvider.of<BlogBloc>(context)
                            .add(UnSelectAllBlogs());
                      },
                      icon: const Icon(Icons.close),
                    ),
              actions: [
                SizedBox(
                  child: isEmptyBox
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddNewBlogPage(),
                            ));
                          },
                          icon: const Icon(
                            CupertinoIcons.add_circled,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            BlocProvider.of<BlogBloc>(context)
                                .add(DeleteSelectedBlogEvent());
                            BlocProvider.of<BlogBloc>(context)
                                .add(BlogFetchAllBlogs());
                          },
                          icon: const Icon(
                            CupertinoIcons.delete,
                          ),
                        ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.w),
                  child: GestureDetector(
                    onLongPress: () {},
                    onTap: () {},
                    child: BlogCart(
                      blog: blog,
                      index: index,
                      selectedIndices: selectedIndices,
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container(
          color: Colors.amber,
        );
      },
    );
  }
}
