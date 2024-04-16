import 'package:blog_app/features/pagingnation/data/user_model/user.dart';
import 'package:blog_app/features/pagingnation/presentation/bloc/user_data_bloc.dart';
import 'package:blog_app/features/pagingnation/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final ScrollController _scrollController = ScrollController();

  final UserDataBloc _dataBloc = UserDataBloc();

  @override
  void initState() {
    super.initState();
    setupScrollController();
    context.read<UserDataBloc>().add(FetchUsersEvent());
    // _dataBloc.add(FetchUsersEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dataBloc.close();
    super.dispose();
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          context.read<UserDataBloc>().add(FetchUsersEvent());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // setupScrollController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is DataLoading && state.isFetchFirst) {
            return const Center(child: CircularProgressIndicator());
          }
          List<User> users = [];
          bool isLoading = false;

          if (state is DataLoading) {
            users = state.oldUsers!;
            isLoading = true;
          } else if (state is DataLoaded) {
            users = state.users!;
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'Users Data',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: users.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < users.length) {
                          return UserCard(item: users[index]);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                // const CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
