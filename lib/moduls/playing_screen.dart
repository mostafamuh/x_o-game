import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_o/shared/cubit/games_cubit.dart';
import 'package:x_o/shared/cubit/games_state.dart';

import 'WinnerPage.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({super.key});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GameCubit>();
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state is GameEnded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WinnerPage(winner: GameCubit.get(context).winner),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  context.pop();
                  GameCubit.get(context).resetGame();
                  },
                icon: const Icon(
                  Icons.arrow_back_ios,
                color: Colors.white,)),
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
            elevation: 5,
          ),
          body: Container(
            padding: EdgeInsets.all(hi*.02),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: hi * .015,
                    horizontal: wi * .05,
                  ),
                  margin: EdgeInsets.only(bottom: hi * .03),
                  decoration: BoxDecoration(
                    color: (cubit.currentPlayer == 'X'
                        ? Colors.orange
                        : Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        cubit.currentPlayer == 'X'
                            ? Icons.close
                            : Icons.circle_outlined,
                        color: Colors.white,
                        size: wi * .07,
                      ),
                      SizedBox(width: wi * .02),
                      Text(
                        'Player: ${cubit.currentPlayer}',
                        style: TextStyle(
                          fontSize: wi * .05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => cubit.onTilePressed(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: cubit.board[index].isEmpty
                              ? Colors.deepPurple.shade300
                              : (cubit.board[index] == 'X'
                              ? Colors.orange
                              : Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            cubit.board[index],
                            style: TextStyle(
                              fontSize: wi*.045,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: hi * .02),
                ElevatedButton(
                  onPressed: cubit.resetGame,
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
                SizedBox(height: hi * .02),
              ],
            ),
          ),
        );
      },
    );
  }
}
