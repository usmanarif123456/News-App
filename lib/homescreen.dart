// ignore_for_file: camel_case_types, avoid_unnecessary_containers, sized_box_for_whitespace, duplicate_ignore

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Model/categoriesnewsmodel.dart';
import 'package:newsapp/Model/newschannelheadlinemodel.dart';
import 'package:newsapp/categoriesscreen.dart';
import 'package:newsapp/detailhomescreen.dart';
import 'package:newsapp/viewmodel/newsviewmodel.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

enum FilterList { bbcNews, aryNews, aljazeeraNews }

class _homescreenState extends State<homescreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM,dd,yyyy');
  String name = 'bbc-news';
  FilterList? selectedMenu;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Categoriesscreen()));


          },
          icon: Image.asset(
            "images/category_icon.png",
            height: 30,
            width: 30,
          ),
        ),
        title: Center(
            child: Text(
          'NEWS',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        )),
        actions: [
          PopupMenuButton(
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text('BBC')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.aryNews, child: Text('ARY NEWS'))
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .5,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModels>(
                future: newsViewModel.fetchNewsChannelHeadlinesModels(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.black,
                        size: 50,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot .data!.articles![index].publishedAt  .toString());
                          return InkWell(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                              author: snapshot .data!.articles![index].author  .toString(),
                             description:snapshot .data!.articles![index].description  .toString(), 
                             newsTitle: snapshot .data!.articles![index].title  .toString(),
                              content: snapshot .data!.articles![index].content  .toString(),
                               newsDate: snapshot .data!.articles![index].publishedAt  .toString(), 
                              newsImage: snapshot .data!.articles![index].urlToImage  .toString(), 
                              source:snapshot .data!.articles![index].source  .toString())));
                          },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    width: width * .9,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * .02),
                                    child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (
                                          context,
                                          url,
                                        ) =>
                                            Container(
                                              child: spinkit2,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error_outline,
                                                color: Colors.red)),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          height: height * .22,
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                child: Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              const Spacer(),
                                              // ignore: sized_box_for_whitespace
                                              Container(
                                                width: width * 0.7,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                        )),
                                                    Text(format.format(dateTime),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
       Padding(
         padding: const EdgeInsets.all(20),
         child: FutureBuilder<CategoriesNewsModels>(
                    future: newsViewModel.fetchCategoriesNewsApi("general"),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitCircle(
                            color: Colors.black,
                            size: 50,
                          ),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.articles!.length,shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                      CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: height*.18,
                                          width: width*.3,
                                          placeholder: (
                                            context,
                                            url,
                                          ) =>
                                              Container(
                                                child: spinkit2,
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error_outline,
                                                  color: Colors.red)),
                                Expanded(child: Container(
                                  height: height*.18,
                                  width: width *.3,
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: [
                                      Text(snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                              maxLines: 3,style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold
                                              )
                                                
                                              ,),
                                              Row(mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot
                                              .data!.articles![index].source!.name
                                              .toString(),
                                              maxLines: 3,style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold
                                              )
                                                
                                              ,),
                                              Text(format.format(dateTime),
                                              maxLines: 3,style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 5,
                                                fontWeight: FontWeight.bold
                                              )
                                                
                                              ,),
                                                ],
                                              )
                                    ],
         
                                  ),
                                ))
                                
                                
                                
                                
                                  ],
                                ),
                              );
                            });
                      }
                    }),
       ),
       
       
       
       
       
       
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitChasingDots(
  size: 50,
  color: Colors.black,
);
