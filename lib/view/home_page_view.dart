import 'package:calc_app_with_provider/res/app_colors.dart';
import 'package:calc_app_with_provider/res/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple100,
      body: Column(children: [
        Expanded(
            child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 20),
                    )),
              ]),
        )),
        Expanded(
            flex: 2,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: buttons.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButton(
                        buttonTap: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: AppColors.greenColor,
                        textColor: AppColors.whiteColor);
                  } else if (index == 1) {
                    return MyButton(
                        buttonTap: () {
                          if(userQuestion.isNotEmpty){
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });

                          }
                        },
                        buttonText: buttons[index],
                        color: AppColors.redColor,
                        textColor: AppColors.whiteColor);
                  } else if (index == buttons.length - 1) {
                    return MyButton(
                        buttonTap: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: AppColors.redColor,
                        textColor: AppColors.whiteColor);
                  } else {
                    return MyButton(
                      buttonTap: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? AppColors.deepPurpleColor
                          : AppColors.deepPurple50Color,
                      textColor: isOperator(buttons[index])
                          ? AppColors.whiteColor
                          : AppColors.deepPurpleColor,
                    );
                  }
                })),
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == "=" || x == "+" || x == "-" || x == "/" || x == "%" || x == "x") {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    try {
      if (userQuestion.isNotEmpty) {
        String finalQuestion = userQuestion;
        finalQuestion = finalQuestion.replaceAll('x', '*');
        Parser p = Parser();
        Expression exp = p.parse(finalQuestion);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        userAnswer = eval.toString();
      }
    } catch (error) {
      userAnswer = error.toString();
    }
  }
}
