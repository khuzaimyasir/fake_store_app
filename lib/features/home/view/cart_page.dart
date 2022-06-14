import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../supabasestart/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static const name = 'CartPage';

  /// Method ot create this page with necessary `BlocProvider`
  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: name),
      builder: (context) => CartPage(),
    );
  }




  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? _currentProfileImageUrl;
  File? _selectedImageFile;
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final String kys = "kys";
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: (_form(context))
     

     );
  }

  Form _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(19)
            .copyWith(top: 19 + MediaQuery.of(context).padding.top),
        children: [
          Row(
            children: [
              ClipOval(
                child: GestureDetector(
                  onTap: () async {
                    try {
                      final pickedImage = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 360,
                        maxHeight: 360,
                        imageQuality: 75,
                      );
                      if (pickedImage == null) {
                        return;
                      }
                      setState(() {
                        _selectedImageFile = File(pickedImage.path);
                      });
                    } catch (e) {
                      // context.showErrorSnackbar('Error while selecting image');
                    }
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: _profileImage(),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: TextFormField(
                  controller: _userNameController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                  ),
                  maxLength: 18,
                  // validator: Validator.username,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          TextFormField(
            controller: _descriptionController,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: const InputDecoration(
              labelText: 'Bio',
            ),
            maxLength: 320,
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // if (!widget.isCreatingAccount) ...[
              InkWell(
                // strokeWidth: 0,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 30),
              InkWell(
                // strokeWidth: 0,
                onTap: () {
                  // _saveImage();
                },
                child: const Text('Save'),
              ),

              // ],
              // GradientButton(
              //   onPressed: () async {
              //     if (!_formKey.currentState!.validate()) {
              //       return;
              //     }
              //     try {
              //       final user =
              //           RepositoryProvider.of<Repository>(context).userId;
              //       if (user == null) {
              //         context.showErrorSnackbar('Your session has expired');
              //         return;
              //       }
              //       final name = _userNameController.text;
              //       final description = _descriptionController.text;

              //       await BlocProvider.of<ProfileCubit>(context).saveProfile(
              //         name: name,
              //         description: description,
              //         imageFile: _selectedImageFile,
              //         //  imageFile: _selectedImageFile, new imagefile because
              //         // .saveProfile repo method saves
              //       );
              //       if (widget.isCreatingAccount) {
              //         Navigator.of(context).pop();
              //       } else {
              //         Navigator.of(context).pop();
              //       }
              //     } catch (err)
              //      {
              //       // context.showErrorSnackbar(
              //       //     'Error occured while saving profile');
              //     }
              //   },
              //   child: const Text('Save'),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileImage() {
    if (_selectedImageFile != null) {
      return Image.file(
        _selectedImageFile!,
        fit: BoxFit.cover,
      );
    } else if (_currentProfileImageUrl != null) {
      return Image.network(
        _currentProfileImageUrl!,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/user.png',
        fit: BoxFit.cover,
      );
    }







    
  }

















  // Future<void> _saveImage( File file) async {
  //   final response = await supabase.storage
  //       .from('public-images')
  //       .upload('/profile/$file', File(file.path));
  //   final error = response.error;
  //   if (response.hasError) {
  //     context.showErrorSnackBar(message: error!.message);
  //   } else {
  //     return;
  //   }
  // }

  // Future<void> _upload() async {
  //   final _picker = ImagePicker();
  //   final imageFile = await _picker.getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 300,
  //     maxHeight: 300,
  //   );
  //   if (imageFile == null) {
  //     return;
  //   }
  //   // setState(() => _isLoading = true);

  //   final bytes = await imageFile.readAsBytes();
  //   final fileExt = imageFile.path.split('.').last;
  //   final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
  //   final filePath = fileName;
  //   final response =
  //       await supabase.storage.from('public-images').uploadBinary(filePath, bytes);

  //   // setState(() => _isLoading = false);

  //   final error = response.error;
  //   if (error != null) {
  //     context.showErrorSnackBar(message: error.message);
  //     return;
  //   }
  //   final imageUrlResponse =
  //       supabase.storage.from('public-images').getPublicUrl(filePath);
  //   // widget.onUpload(imageUrlResponse.data!);
  // }
  
}

// do this aqniyet rn imp write all code from github

// forst copy and then write again supa method functions

// https://github.com/igdmitrov/AqNiyet
// also give the option to save ss into db like firebase save screenshot video
// for cart checkoutv to save data
//  Future<void> _saveData() async {
// setState(() {
//   _isLoading = true;
// });

// if (_formKey.currentState != null &&
//     _formKey.currentState!.validate() &&
//     isAuthenticated()) {
//   _formKey.currentState!.save();

//   if (_category != null && _city != null && _phoneCode != null) {
//     final model = Advert(
//       id: '',
//       categoryId: _category!.id,
//       name: _nameController.text,
//         description: _descriptionController.text,
//         cityId: _city!.id,
//         address: _addressController.text,
//         phoneCodeId: _phoneCode!.id,
//         phone: _phoneController.text,
//         enabled: _enabled,
//         createdBy: getCurrentUserId(),
//       );

//       final response = await context.read<AppService>().createAdvert(model);
//       final error = response.error;
//       if (response.hasError) {
//         context.showErrorSnackBar(message: error!.message);
//       } else {
//         final advertId =
//             (((response.data) as List<dynamic>)[0]['id']) as String;

//         for (var image in _images) {
//           await _saveImage(advertId, image);
//         }

//         context.showSnackBar(message: 'You created a new item');
//         Navigator.of(context).pushReplacementNamed(MainPage.routeName);
//       }
//     }
//   }

//   setState(() {
//     _isLoading = false;
//   });
// }
