import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_o/shared/cubit/games_cubit.dart';
import 'package:x_o/shared/cubit/games_state.dart';

class Settingofgame extends StatefulWidget {
  const Settingofgame({super.key});

  @override
  State<Settingofgame> createState() => _SettingofgameState();
}

class _SettingofgameState extends State<Settingofgame> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Timer _timer;
  bool _isScaled = false;

  @override
  void initState() {
    super.initState();

    // Animation controller for color animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.deepPurple,
    ).animate(_controller);

    // Timer to trigger size animation
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _isScaled = !_isScaled;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAnimatedButton(
                  context,
                  label: 'Easy',
                  onTap: () => context.push('/PlayingWithComputer', extra: 0),
                  hi: hi,
                  wi: wi,
                ),
                SizedBox(height: hi * .03),
                _buildAnimatedButton(
                  context,
                  label: 'Medium',
                  onTap: () => context.push('/PlayingWithComputer', extra: 1),
                  hi: hi,
                  wi: wi,
                ),
                SizedBox(height: hi * .03),
                _buildAnimatedButton(
                  context,
                  label: 'Hard',
                  onTap: () => context.push('/PlayingWithComputer', extra: 2),
                  hi: hi,
                  wi: wi,
                ),
                SizedBox(height: hi * .03),
                _buildAnimatedButton(
                  context,
                  label: 'Playing With Friend',
                  onTap: () => context.push('/PlayingScreen'),
                  hi: hi,
                  wi: wi,
                ),
                SizedBox(height: hi * .03),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButton(BuildContext context,
      {required String label, required VoidCallback onTap, required double hi, required double wi}) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          width: wi * 0.8,
          height: hi * 0.07,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_colorAnimation.value ?? Colors.blue, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: wi * .045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
