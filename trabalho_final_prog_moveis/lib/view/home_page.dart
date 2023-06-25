import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_final_prog_moveis/constants/app_colors.dart';
import 'package:trabalho_final_prog_moveis/view/clock_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);


    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSecondaryColor, // Defina a cor de fundo desejada aqui
                ),
                child: const Column(
                  children: <Widget>[
                  Icon(
                    Icons.access_time,
                    size: 50,
                    color: AppColors.kPrimaryColor,
                  ),
                    Text(
                      'Alarme',
                      style: TextStyle(color: AppColors.kTextStyle, fontSize: 14),
                    ),
                  ],
                )
              )
            ],
          ),
          const VerticalDivider(
            color: Colors.black,
            width: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Bons Estudos',
                    style: TextStyle(color: AppColors.kTextStyle, fontSize: 24),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    formattedDate,
                    style: TextStyle(color: AppColors.kTextStyle, fontSize: 20),
                  ),
                  const Text(
                    'Clock',
                    style: TextStyle(color: AppColors.kTextStyle, fontSize: 24),
                  ),
                  ClockView(),
                  const Text(
                    'Fuso Horário',
                    style: TextStyle(color: AppColors.kTextStyle, fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children:<Widget>[
                      Icon(
                        Icons.language,
                        color: AppColors.kTextStyle
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Brasil',
                          style: TextStyle(color: AppColors.kTextStyle, fontSize: 24),
                        )
                    ]
                  )            
                ],
              )
            ),
          ),
        ],
      )
    );
  }
}

