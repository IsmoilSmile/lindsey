import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/src/widgets/async.dart';

class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Lindsey"),
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
        builder: (context, item){
          if(item.hasData){
            Map? jsonMap = json.decode(item.data!);
            List? listSong = jsonMap?.keys.toList();
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Lindsey_Stirling_01_26_2018_-8_%2826271965348%29.jpg/1200px-Lindsey_Stirling_01_26_2018_-8_%2826271965348%29.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: ListView.builder(
              itemCount:  listSong?.length,
                itemBuilder: (context, index){
                var peth = listSong![index].toString();
                var title = peth.split("/").last.toString();
                title = title.replaceAll("%20", "");
                title = title.split(".").first;
                return Container(
                  margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  padding: const EdgeInsets.only(top: 20, bottom: 20),

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 2,color: Colors.orange),
                      ),
                      child: ListTile(
                        title:  Text(title,style: const TextStyle(color: Colors.orange),),
                        subtitle: Text("peth: $peth",style: const TextStyle(color: Colors.orange),),
                        leading: const Icon(Icons.audiotrack, size: 20),
                        onTap: () async {
                          await audioPlayer.setAsset(peth);
                          await audioPlayer.play();
                        },
                      ),
                    ),
                  ),
                );
                },
              ),
            );
          }else{
            return const Center(
              child: Text("Has not song"),
            );
          }
        },
      ),
    );
  }
}
