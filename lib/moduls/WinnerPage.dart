import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_o/shared/cubit/games_cubit.dart';
import 'package:x_o/shared/cubit/games_state.dart';

class WinnerPage extends StatelessWidget {
  final String winner;

  const WinnerPage({super.key, required this.winner});

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    return BlocConsumer<GameCubit, GameState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          GameCubit.get(context).resetGame();
          context.pop();
          },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          "Game X-O",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: wi*.045,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              GameCubit.get(context).resetGame();
              context.push('/');
            },
          ),
        ],
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: 1.2,
                duration: const Duration(seconds: 2),
                curve: Curves.elasticOut,
                child: Icon(
                  winner == 'Tie' ? Icons.handshake : Icons.emoji_events,
                  color: Colors.amber,
                  size: wi * 0.25,
                ),
              ),
              SizedBox(height: hi * 0.05),
              Text(
                winner == 'Tie' ? 'It\'s a Tie!' : '$winner Wins!',
                style:  TextStyle(
                  fontSize: wi*.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: hi * 0.08),
              ElevatedButton(
                onPressed: (){
                  context.pop();
                  GameCubit.get(context).resetGame();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: hi * .02,
                    horizontal: wi * .2,
                  ),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: Text(
                  'إعادة اللعبة',
                  style: TextStyle(
                    fontSize: wi * .045,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: hi * 0.02),
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                  GameCubit.get(context).resetGame();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: hi * 0.02, horizontal: wi * 0.15),
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: Text(
                  'الرئسيه',
                  style: TextStyle(
                    fontSize: wi*.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  },
);
  }
}
