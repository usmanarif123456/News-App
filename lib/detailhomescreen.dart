

// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
   NewsDetailScreen(
      {super.key,
      required this.author,
      required this.description,
      required this.newsTitle,
      required this.content,
      required this.newsDate,
      required this.newsImage,
      required this.source});
  String newsImage, newsTitle, newsDate, author, description, content, source;
  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM,dd,yyyy');
  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.sizeOf(context).height * 1;
    //final width = MediaQuery.sizeOf(context).width * 1;
    DateTime dateTime=DateTime.parse(widget.newsDate);
    return  Scaffold(
appBar: AppBar(
  elevation: 0,
),
body: Stack(
  children: [
    Container(height: height*.45,
      child: CachedNetworkImage(imageUrl: widget.newsImage,
     placeholder: (context,url)=>const Center(child: CircularProgressIndicator()),
     
      ),
    )
  ,Container(
height: height*.6,
margin: EdgeInsets.only(top: height*.4),
decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
  child: ListView(
    children: [
      Text(widget.newsTitle,style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 15),),
    const SizedBox(height: 20,),
    Row(
      children: [
        Text(widget.source,style: GoogleFonts.aBeeZee(fontSize: 12),),
         Text(format.format(dateTime),style: GoogleFonts.aBeeZee(fontSize: 12),)
      ],
    ),SizedBox(height: 12,),
    Text(widget.description,style: GoogleFonts.aBeeZee(fontSize: 12),)
    ],
  ),
  
  
  )
  
  
  ],
),
    );
  }
}
