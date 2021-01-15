import 'package:flutter/material.dart';
import 'package:flutter_stacked_architecture_starter/app/utils/list.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart' show HomeViewModel;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey,
            currentIndex: 2,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_play_outlined),
                label: 'Coming Soon',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.download_outlined),
                label: 'Downloads',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'More',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                FeaturedMovie(size: size),
                ListHeader(
                  title: 'Popular on Netflix',
                ),
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: MovieHorizontalList(),
                ),
                ListHeader(
                  title: 'Trending Now',
                ),
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: MovieHorizontalList(),
                ),
                ListHeader(
                  title: 'Watch it Again',
                ),
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: MovieHorizontalList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieHorizontalList extends StatelessWidget {
  MovieHorizontalList({
    Key key,
  }) : super(key: key);

  final List _movies = [
    {
      'name': 'Wonderwoman 1984',
      'image': 'assets/movies/wonderwoman-1984.jpg',
    },
    {
      'name': 'The Prom',
      'image': 'assets/movies/the-prom-poster.jpg',
    },
    {
      'name': 'Another Round',
      'image': 'assets/movies/another-round-poster.jpg'
    },
    {
      'name': 'Arch Enemy',
      'image': 'assets/movies/archenemyposter.jpg',
    },
    {
      'name': 'Euro Vision Song',
      'image':
          'assets/movies/eurovision_song_contest_the_story_of_fire_saga_xlg.jpg'
    },
    {
      'name': 'Rogue',
      'image': 'assets/movies/Rogue-Megan-Fox-poster-913.jpg',
    },
    {
      'name': 'Happiest Season',
      'image': 'assets/movies/happiest-season-poster.jpg'
    },
    {
      'name': 'Skyline 3',
      'image': 'assets/movies/Skyline-3-poster-913.jpg',
    },
    {
      'name': 'Wolfwalkers',
      'image': 'assets/movies/wolfwalkers-posters.jpg',
    },
  ];

  List get movies => shuffle(_movies);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        bool isFirst = index == 0;
        bool isLast = ((movies.length) - 1) == index;
        dynamic movie = movies[index];

        return Container(
          width: 120,
          margin: isFirst
              ? const EdgeInsets.only(left: 10)
              : isLast
                  ? const EdgeInsets.only(right: 10)
                  : null,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            image: DecorationImage(
              image: AssetImage(
                movie['image'],
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 15),
      itemCount: movies.length,
    );
  }
}

class ListHeader extends StatelessWidget {
  final String title;

  const ListHeader({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedMovie extends StatelessWidget {
  FeaturedMovie({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  final String moviePosterUrl =
      'https://i.pinimg.com/originals/0e/e0/83/0ee083ab8efaf374fdf17f94ffa3cb67.jpg';
  final List<String> featuredMovieCategoies = [
    'Thriller',
    'Cool',
    'Superb',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(
              Rect.fromLTRB(0, 0, rect.width, rect.height),
            );
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            height: 530,
            width: size.width,
            // padding: const EdgeInsets.symmetric(vertical: 150),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              image: DecorationImage(
                image: NetworkImage(
                  moviePosterUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          height: size.height * 0.5,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NetflixIcon(
                    height: 30,
                    width: 30,
                  ),
                  Text('BEST MOVIE OF ALL TIME')
                ],
              ),
              Text(
                'Avengers: End Game',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Thriller'),
                  SizedBox(width: 5),
                  Text(
                    '•',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('Cool'),
                  SizedBox(width: 5),
                  Text(
                    '•',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('Superb'),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              Container(
                height: 150,
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: Column(
                        children: [Icon(Icons.add), Text('My List')],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () => null,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow),
                          Text('Play'),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      child: Column(
                        children: [Icon(Icons.info_outline), Text('Info')],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CustomAppBar(size: size),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[900],
      color: Colors.transparent,
      width: size.width,
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NetflixIcon(),
          appBarNavigationItem('TV Shows'),
          appBarNavigationItem('Movies'),
          appBarNavigationItem('My List'),
        ],
      ),
    );
  }

  Text appBarNavigationItem(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class NetflixIcon extends StatelessWidget {
  final double height;
  final double width;

  const NetflixIcon({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/227_Netflix_logo-512.png',
      height: height ?? 40,
      width: width ?? 40,
    );
  }
}
