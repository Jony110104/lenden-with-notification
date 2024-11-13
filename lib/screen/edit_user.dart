import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/config/async_states.dart';
import 'package:lenden/config/toast.dart';
import 'package:lenden/functions/core/input_decor.dart';
import 'package:lenden/functions/core/update_user.dart';
import 'package:lenden/functions/core/user_model.dart';
import 'package:lenden/functions/core/user_provider.dart';
import 'package:lenden/services/firebase.dart';

class EditUserData extends ConsumerStatefulWidget {
  const EditUserData({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditUserDataState();
}

class _EditUserDataState extends ConsumerState<EditUserData> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _syncData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserStoreModel?>(
      userDetailsProvider,
      (_, user) {
        if (user != null) {
          _syncData();
        }
      },
    );
    final userUpdateProvider = ref.watch(updateUserProvider);
    final userUpdateNotifier = ref.watch(updateUserProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: AppInputDecor.inputDecor().copyWith(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bioController,
                decoration: AppInputDecor.inputDecor().copyWith(
                  labelText: 'Bio',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: AppInputDecor.inputDecor().copyWith(
                  labelText: 'Phone',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: AppInputDecor.inputDecor().copyWith(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              userUpdateProvider == AsyncState.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final user = ref.read(userDetailsProvider);
                          UserStoreModel updatedUser = UserStoreModel(
                            id: '',
                            email: '',
                          );
                          if (user != null) {
                            updatedUser = user;
                          }
                          updatedUser = updatedUser.copyWith(
                            name: _nameController.text,
                            bio: _bioController.text,
                            phone: _phoneController.text,
                            photoUrl: _photoUrlController.text,
                            email: _emailController.text,
                          );
                          userUpdateNotifier.updateUser(updatedUser);
                          Toast.showSuccess(context, 'Profile updated');
                        }
                      },
                      child: const Text('Save'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _syncData() {
    final user = ref.read(userDetailsProvider);
    _nameController.text = user?.name ?? '';
    _bioController.text = user?.bio ?? '';
    _phoneController.text = user?.phone ?? '';
    _photoUrlController.text = user?.photoUrl ?? '';
    _emailController.text =
        AppFirebaseService.currentUserEmail ?? user?.email ?? '';
  }
}
