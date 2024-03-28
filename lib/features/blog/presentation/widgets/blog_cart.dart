import 'package:blog_app/core/utils/functions/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogCart extends StatelessWidget {
  final Blog blog;
  final int index;
  final List<int> selectedIndices;
  const BlogCart(
      {super.key,
      required this.blog,
      required this.index,
      required this.selectedIndices});

  void singleTapOperations(BuildContext context) {
    if (selectedIndices.isEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlogViewerPage(
            blog: blog,
          ),
        ),
      );
    }
    if (selectedIndices.contains(index)) {
      BlocProvider.of<BlogBloc>(context)
          .add(UnSelectedBlogEvent(index, blog.id));
    } else {
      BlocProvider.of<BlogBloc>(context).add(SelectedBlogEvent(index, blog.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => singleTapOperations(context),
          onLongPress: () {
            if (selectedIndices.isEmpty) {
              BlocProvider.of<BlogBloc>(context)
                  .add(SelectedBlogEvent(index, blog.id));
            }
          },
          child: Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: NetworkImage(blog.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,

              children: [
                selectedIndices.contains(index)
                    ? Container(
                        alignment: Alignment.bottomRight,
                        width: double.infinity,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 24.h,
                        ),
                      )
                    : const SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 8.h),
                      decoration: BoxDecoration(
                        color: Colors.black87.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${calculateReadingTime(blog.content)} min",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Read More...",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
