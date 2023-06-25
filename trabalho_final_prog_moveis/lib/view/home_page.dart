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
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Home',
              style: TextStyle(
              fontFamily: 'avenir',
              color: AppColors.kTextStyle,
              fontSize: 24
              ),
            ),
            IconButton(
              icon: const Icon(Icons.person_2_outlined),
              onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Login()),
              //   );
              },
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.kSecondaryColor,
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildElevatedButton('Alarme', Icons.access_alarm),
              buildElevatedButton('Cronômetro', Icons.timer)
            ],
          ),
          const VerticalDivider(
            color: Color.fromARGB(255, 4, 88, 83),
            width: 1,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      'Bons Estudos',
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: AppColors.kTextStyle,
                        fontSize: 24
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            fontFamily: 'avenir',
                            color: AppColors.kTextStyle,
                            fontSize: 48
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontFamily: 'avenir',
                            color: AppColors.kTextStyle,
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClockView(
                        size: 250,
                      ),
                    ),
                  ),
                  const Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text(
                        'Fuso Horário',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          color: AppColors.kTextStyle,
                          fontSize: 24
                        ),
                      ),
                      SizedBox(height: 16),
                    Row(
                      children:<Widget>[
                        Icon(
                          Icons.language,
                          color: AppColors.kTextStyle
                          ),
                          SizedBox(width: 16),
                        Text(
                          'Brasil',
                          style: TextStyle(
                            fontFamily: 'avenir',
                            color: AppColors.kTextStyle,
                            fontSize: 24
                          ),
                        )
                      ]
                    )
                                  ]
                                ),
                  ),
                              
                ],
              )
            ),
          ),
        ],
      )
    );
  }

  Padding buildElevatedButton(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kSecondaryColor, // Defina a cor de fundo desejada aqui
        ),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: AppColors.kPrimaryColor,
            ),
            SizedBox(height: 16),
            Text(
              title ?? '',
              style: const TextStyle(
                fontFamily:'avenir',
                color: AppColors.kTextStyle,
                fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

