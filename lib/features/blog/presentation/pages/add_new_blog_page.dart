import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/constants/colors.dart';
import 'package:blog_app/core/utils/constants/image_strings.dart';
import 'package:blog_app/core/utils/constants/validation_mixin.dart';
import 'package:blog_app/core/common/widgets/custom_textfield.dart';
import 'package:blog_app/core/utils/functions/pick_image.dart';
import 'package:blog_app/core/utils/functions/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewBlogPage extends StatefulWidget {
  AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> with ValidationsMixin {
  final blogFormKey = GlobalKey<FormState>();
  final blogTitleController = TextEditingController();
  final blogContentController = TextEditingController();

  List<String> selectedTopic = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (blogFormKey.currentState!.validate() &&
        selectedTopic.isNotEmpty &&
        image != null) {
      print("Saved button clicked");
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      context.read<BlogBloc>().add(
            BlogUpload(
              posterId: posterId,
              title: blogTitleController.text.trim(),
              content: blogContentController.text.trim(),
              image: image!,
              topics: selectedTopic,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: uploadBlog,
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            print("here is your error: ${state.error}");
            showSnackBar(
              context,
              "",
              state.error,
              TColors.failedBackgroundColor,
              TColors.failedAssetsColor,
              TImages.failure,
            );
          } else if (state is BlogUploadSuccess) {
            showSnackBar(
              context,
              "Congratulations!",
              "Your blog has been uploaded successfully!",
              TColors.successBackgroundColor,
              TColors.successAssetsColor,
              TImages.failure,
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BlogPage()),
              ModalRoute.withName('/'),
            );
          }
        },
        builder: (context, state) {
          // if (state is BlogLoading) {
          //   return const Loader();
          // }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: blogFormKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                                height: 150.h,
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ))),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              radius: Radius.circular(28.r),
                              dashPattern: [10, 4],
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              color: Color(0XFFCED4F7),
                              child: Container(
                                height: 150.h,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40.h,
                                    ),
                                    SizedBox(height: 15.h),
                                    Text(
                                      "Select your image",
                                      style: TextStyle(fontSize: 15.sp),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 16.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Technology',
                          'Business',
                          'Programming',
                          'Entertainment',
                        ]
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.all(5.h),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopic.contains(e)) {
                                      selectedTopic.remove(e);
                                    } else {
                                      selectedTopic.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(
                                      e,
                                      style: TextStyle(
                                          color: selectedTopic.contains(e)
                                              ? Colors.white
                                              : null),
                                    ),
                                    color: selectedTopic.contains(e)
                                        ? const MaterialStatePropertyAll(
                                            Color(0XFF2F66ED))
                                        : null,
                                    side: selectedTopic.contains(e)
                                        ? null
                                        : const BorderSide(
                                            color: Color(0XFFCED4F7)),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: blogTitleController,
                      textAlignVertical: TextAlignVertical.bottom,
                      hintText: "Blog Title",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      validator: validatedBlogContent,
                      maxLines: 1,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: blogContentController,
                      textAlignVertical: TextAlignVertical.bottom,
                      hintText: "Blog Content",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      validator: validatedBlogContent,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
