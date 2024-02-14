// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/helpers/hive_service.dart';

class CoursesItemWidget extends StatefulWidget {
  final int id;
  final String name;
  final String link;
  final String image;

  const CoursesItemWidget({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
    super.key,
  });

  @override
  _CoursesItemWidgetState createState() => _CoursesItemWidgetState();
}

class _CoursesItemWidgetState extends State<CoursesItemWidget> {
  late bool isFavorite;

  _launchURL(dynamic url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteService.isFavorite(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          _launchURL(Uri.parse(widget.link));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.network(
                  widget.image,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isFavorite = !isFavorite;
                      });

                      if (isFavorite) {
                        await FavoriteService.addToFavorites(widget.id);
                        _showSnackBar('Added to favorites: ${widget.name}',
                            Colors.indigo);
                      } else {
                        await FavoriteService.removeFromFavorites(widget.id);
                        _showSnackBar('Removed from favorites: ${widget.name}',
                            Colors.red);
                      }
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
