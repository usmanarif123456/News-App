// ignore_for_file: camel_case_types, unused_local_variable, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Model/categoriesnewsmodel.dart';
import 'package:newsapp/homescreen.dart';
import 'package:newsapp/viewmodel/newsviewmodel.dart';

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key});

  @override
  State<Categoriesscreen> createState() => _categoriesscreenState();
}

class _categoriesscreenState extends State<Categoriesscreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM,dd,yyyy');
  String categoryName = 'general';
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Heath',
    'Sports',
    'Buisness',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
       final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        categoryName = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: categoryName == categoriesList[index]
                                  ? const Color.fromARGB(255, 0, 13, 87)
                                  : const Color.fromARGB(255, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(
                              categoriesList[index].toString(),
                              style: const TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),const SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModels>(
                  future: newsViewModel.fetchCategoriesNewsApi(categoryName),
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
                          itemCount: snapshot.data!.articles!.length,
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
                                padding: EdgeInsets.only(left: 20),
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
            )
          ],
        ),
      ),
    );
  }
}
