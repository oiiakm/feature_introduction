import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'introduction_card.dart';
import 'custom_progress_indicator.dart';

class IntroductionOnboarding extends StatefulWidget {
  final List<IndroductionCard>? introductionCardList;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? skipTextStyle;
  final Function()? onTapSkipButton;

  const IntroductionOnboarding({
    Key? key,
    this.introductionCardList,
    this.onTapSkipButton,
    this.backgroundColor,
    this.foregroundColor,
    this.skipTextStyle = const TextStyle(fontSize: 20),
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _IntroductionOnboardingState createState() => _IntroductionOnboardingState();
}

class _IntroductionOnboardingState extends State<IntroductionOnboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  double progressPercent = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              color: widget.backgroundColor ??
                  Theme.of(context).colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 550.0,
                        child: PageView(
                          physics: const ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: widget.introductionCardList!,
                        ),
                      ),
                    ),
                    _customProgress(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: widget.onTapSkipButton,
                    child: Text('Skip', style: widget.skipTextStyle),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customProgress() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CustomProgressIndicator(
            backgroundColor: Colors.white,
            foregroundColor:
                widget.foregroundColor ?? Theme.of(context).primaryColor,
            value: ((_currentPage + 1) *
                1.0 /
                widget.introductionCardList!.length),
          ),
        ),
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (widget.foregroundColor ?? Theme.of(context).primaryColor)
                .withOpacity(0.5),
          ),
          child: IconButton(
            onPressed: () {
              _currentPage != widget.introductionCardList!.length - 1
                  ? _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    )
                  : widget.onTapSkipButton!();
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            iconSize: 15,
          ),
        )
      ],
    );
  }
}
