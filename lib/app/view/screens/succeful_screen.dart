import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurent_test1/app/helper/constants.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({Key? key}) : super(key: key);

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      _animationController.stop();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text('Successful Page'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: fireStore
                .collection('User')
                .doc(firebaseAuth.currentUser!.uid)
                .collection('paymentHistory')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final docs = snapshot.data!.docs;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _animation.value,
                        child: _animation.value == 1
                            ? const Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 100.0,
                              )
                            : const SpinKitCircle(
                                color: Colors.green,
                                size: 100.0,
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '₹ ${docs[0].get('payment') ?? ''}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'Payment Successful!',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

//This is for animation Icon.

// class VerificationIcon extends StatefulWidget {
//   final bool isVerified;
//   final VoidCallback? onAnimationComplete;

//   const VerificationIcon({
//     Key? key,
//     required this.isVerified,
//     this.onAnimationComplete,
//   }) : super(key: key);

//   @override
//   _VerificationIconState createState() => _VerificationIconState();
// }

// class _VerificationIconState extends State<VerificationIcon>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//     if (widget.isVerified) {
//       _controller.forward();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant VerificationIcon oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.isVerified && !oldWidget.isVerified) {
//       _controller.forward().then((_) {
//         if (widget.onAnimationComplete != null) {
//           widget.onAnimationComplete!();
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedIcon(
//       icon: AnimatedIcons.add_event,
//       progress: _animation,
//       size: 100,
//     );
//   }
// }
