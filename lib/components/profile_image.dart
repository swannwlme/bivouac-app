import 'package:bivouac/components/user_data_stream.dart';
import 'package:bivouac/database/auth.dart';
import 'package:bivouac/database/data_storage.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/get_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final double size;
  final bool canModify;
  const ProfileImage({super.key, this.size=25, this.canModify=false});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {

    return UserStreamBuilder(builder: (data) {
      if (widget.canModify){
        return GestureDetector(
          onTap: () async {
            await getImage().then((value) async {
              if(value.path != ''){
                await DataStorage().uploadFile("users/profile_image/${Auth().currentUser!.uid}", value).then((value) {
                  Auth().users.doc(Auth().currentUser!.uid).update({
                    'profile_image': value
                  });
                });
              }
            });
          },
          child: Stack(
            children: [
              data['profile_image'] != null ? CircleAvatar(
                radius: widget.size,
                backgroundImage: NetworkImage(data['profile_image']),
              ) : CircleAvatar(
                radius: widget.size,
                backgroundImage: const AssetImage("assets/images/default_pp.png"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: widget.size*0.25,
                  backgroundColor: Colpal.brown,
                  child: Icon(Icons.edit, color: Colors.white, size: widget.size*0.25,)
                ),
              )
            ],
          ),
        );
      } else {
        if (data['profile_image'] != null) {
          return CircleAvatar(
            radius: widget.size,
            backgroundImage: NetworkImage(data['profile_image']),
          );
        } else {
          return CircleAvatar(
            radius: widget.size,
            backgroundImage: const AssetImage("assets/images/default_pp.png"),
          );
          
        }
      }
    },);
  }
}