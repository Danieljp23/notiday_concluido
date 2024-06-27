import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notiday_1/screens/login.dart';
import "package:url_launcher/url_launcher.dart"; // Importação necessária para abrir URLs
import 'package:easy_splash_screen/easy_splash_screen.dart';

class Carrossel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        items: [
          GestureDetector(
            child: Container(
              
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(20) ,
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: AssetImage('assets/uber.png'),
                      fit:BoxFit.cover),
                      ),
            ),
            onTap: () async {
              const url = 'https://www.uber.com/br/pt-br/';
              await launch(url);
            },
          ),
          GestureDetector(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(20) ,
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                  image: DecorationImage(
                      image: AssetImage('assets/99.png'),
                      fit:BoxFit.cover),),
            ),
            onTap:()async{
            const url = 'https://99app.com/';
            await launch(url);     
            },
          ),
          GestureDetector(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(20) ,
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                  image: DecorationImage(
                      image: AssetImage('assets/GoogleMaps.png'),
                      fit:BoxFit.cover)),
            ),
           onTap: () async {
            const url = 'https://www.google.com.br/maps/place/R.+Maur%C3%ADcio+Galli';
            await launch(url);

           },
          ),
          GestureDetector(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(20) ,
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                  image: DecorationImage(
                      image: AssetImage('assets/waze.png'),
                      fit:BoxFit.cover)),
            ),
            onTap: () async {
            const url = 'https://www.waze.com/pt-PT/live-map/';
            await launch(url);  
              
            },
          )
        ],
        options: CarouselOptions(
            viewportFraction: 0.30,
            autoPlay:true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            ),
      ),
    );
  }
}

class Splash extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('images/NOTIDAY.gif'),
      showLoader: true, // icone de carregamento
      loadingText: const Text('Carregando..'),
      durationInSeconds: 5,
      navigator: const Notiday(), // Aqui colocamos o que deve ser aberto após o Splash
    );
  }
}