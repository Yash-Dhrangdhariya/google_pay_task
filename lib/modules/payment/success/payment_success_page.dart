import 'package:flutter/material.dart';
import 'package:google_pay_task/models/upi_model.dart';
import 'package:google_pay_task/resources/app_text_styles.dart';
import 'package:google_pay_task/resources/audios.dart';
import 'package:google_pay_task/widgets/circle_widget.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({
    required this.upi,
    super.key,
  });

  final UpiModel upi;

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _transDetailController;
  late Animation<double> _outerScaleAnimation;
  late Animation<double> _innerScaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _transDetailFadeAnimation;

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _outerScaleAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    _innerScaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _transDetailController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _transDetailFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _transDetailController,
        curve: Curves.ease,
      ),
    );
    //
    _controller
      ..forward()
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            player
                .setAsset(Audios.transactionAudio)
                .then((value) => player.play());
            _transDetailController
              ..reset()
              ..forward();
          }
        },
      );
  }

  @override
  void dispose() {
    player.dispose();
    _controller.dispose();
    _transDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _outerScaleAnimation,
                  child: Center(
                    child: Circle(
                      radius: size.width / 2,
                      color: Colors.blue.withOpacity(0.2),
                      child: ScaleTransition(
                        scale: _innerScaleAnimation,
                        child: Center(
                          child: Circle(
                            radius: size.width / 2 - 40,
                            color: Colors.blue,
                            child: const Icon(
                              Icons.check_rounded,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromLTRB(0, 0, 0, -size.height),
                end: RelativeRect.fromLTRB(0, 0, 0, -(size.height * 0.36)),
              ).animate(
                CurvedAnimation(
                  parent: _transDetailController,
                  curve: Curves.ease,
                ),
              ),
              child: FadeTransition(
                opacity: _transDetailFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹${widget.upi.amount}',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.amountField.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Paid to ${widget.upi.displayName}',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.fontMediumLarge.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.upi.upiId,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.fontMedium.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMMd()
                            .add_jm()
                            .format(widget.upi.dateTime),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.fontMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'UP transaction ID: ${widget.upi.upiTransactionId}',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.fontMedium.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      FilledButton(
                        onPressed: () => Navigator.maybePop(context),
                        child: const Text('Done'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
