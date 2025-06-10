import 'dart:async';
import 'package:edunourish/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ParentSlider extends StatefulWidget {
  const ParentSlider({super.key});

  @override
  _ParentSliderState createState() => _ParentSliderState();
}

class _ParentSliderState extends State<ParentSlider> {
  late final PageController _pageController;
  late final Timer _timer;

  // Example list of texts to display in each slide
  final List<String> _texts = [
    'Welcome to EduNourish',
    'Latest School News',
    'Upcoming Events',
    'Parent-Teacher Meeting',
    'Holiday Schedule',
    'Exam Tips & Tricks',
    'Nutrition Guidelines',
    'Health & Safety',
    'Student Achievements',
    'Contact Information',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        final nextPage = _pageController.page!.round() < _texts.length - 1
            ? _pageController.page!.round() + 1
            : 0;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: SizedBox(
            height: screenHeight * 0.28,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _texts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsPageParent(),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: ourMainColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _texts[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: _texts.length,
          effect: const ExpandingDotsEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: ourMainColor,
            dotColor: Colors.grey,
          ),
          onDotClicked: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class NewsPageParent extends StatelessWidget {
 

  const NewsPageParent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'news.type',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'news.photo',
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stack) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'news.title',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          const Text(
           ' news.content',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          const Text(
            'Date: 12/12/2023',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff008f99),
            ),
          ),
        ],
      ),
    );
  }
}