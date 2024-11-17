import 'package:flutter/material.dart';
import 'package:flutter_animation/flutter_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const List<String> animationTypeList = [
    'fadeIn',
    'slideRTL',
    'slideLTR',
    'slideUp',
    'scaleLTR',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Animation')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: animationTypeList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListViewScreen(
                      animationName: animationTypeList[index],
                    ),
                  ),
                ),
                child: Card(
                  child: ListTile(
                    title: Text(animationTypeList[index]),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            },
          ),
          const Text('\n Animated Text \n'),
          const Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('CountUp'),
                    FlutterAnimatedText(
                      startValue: 0.0,
                      endValue: 100,
                      animationType: TextAnimationType.countUp,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('CountDown'),
                    FlutterAnimatedText(
                      startValue: 0,
                      endValue: 100.0,
                      animationType: TextAnimationType.countDown,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Typing'),
                    FlutterAnimatedText(
                      normalText: "Hello...",
                      animationType: TextAnimationType.typing,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ListViewScreen extends StatefulWidget {
  final String animationName;

  const ListViewScreen({super.key, required this.animationName});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  late AnimationType animationType;
  @override
  void initState() {
    super.initState();
    animationType = getAnimationType(animationName: widget.animationName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animationName),
      ),
      body: Container(
        color: Colors.amber,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return FlutterAnimatedView(
              animationType: animationType,
              index: index,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Visibility(
                              visible: animationType == AnimationType.slideRTL,
                              child: const Icon(
                                Icons.arrow_back_ios,
                              )),
                          Text('Item $index'),
                          const Spacer(),
                          Visibility(
                            visible: animationType == AnimationType.slideLTR,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AnimationType getAnimationType({required String animationName}) {
    switch (animationName) {
      case 'fadeIn':
        return AnimationType.fadeIn;

      case 'slideRTL':
        return AnimationType.slideRTL;

      case 'slideLTR':
        return AnimationType.slideLTR;

      case 'slideUp':
        return AnimationType.slideUp;

      case 'flip':
        return AnimationType.flip;

      case 'scaleLTR':
        return AnimationType.scaleLTR;
      case 'none':
      default:
        return AnimationType.none;
    }
  }
}
