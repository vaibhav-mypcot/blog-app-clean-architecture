import 'package:blog_app/core/utils/functions/calculate_reading_time.dart';
import 'package:blog_app/core/utils/functions/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    String content = blog.content;
    String firstWord = content.split(' ').first.characters.first;
    String restOfContent = content.substring(firstWord.length);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'By ${blog.posterName!}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "${formatDateBydMMMYYYY(blog.updatedAt)} .${calculateReadingTime(blog.content)} min",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
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
                ),
                SizedBox(height: 26.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${firstWord.substring(0, 1).toUpperCase()}${firstWord.substring(1).characters}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: restOfContent,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )

                // Text(
                //   blog.content.isNotEmpty
                //       ? blog.content[0]
                //       : '', // First character
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   blog.content.length > 1
                //       ? blog.content.substring(1)
                //       : '', // Rest of the content
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
