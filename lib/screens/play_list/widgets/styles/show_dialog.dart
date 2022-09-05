// ignore_for_file: must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/controller/playlist_db.dart';
import 'package:music_player/db/music_db.dart';

class PlaylistShowDialog extends StatelessWidget {
  PlaylistShowDialog({super.key});
  final nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PlaylistController _controller = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: height / 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Create Your Playlist',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: ' Playlist Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter playlist name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        nameController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          whenButtonClicked();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = Playlistmodel(name: name, songid: []);
      _controller.playlistAdd(music);
      nameController.clear();
    }
  }
}
