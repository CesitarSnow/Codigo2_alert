import 'package:codigo2_alerta2/api/api_services.dart';
import 'package:codigo2_alerta2/api/path_production.dart';
import 'package:codigo2_alerta2/assets_data.dart';
import 'package:codigo2_alerta2/models/user_model.dart';
import 'package:codigo2_alerta2/pages/buttom_custom_widget.dart';
import 'package:codigo2_alerta2/pages/home_page.dart';
import 'package:codigo2_alerta2/provider/example_provider.dart';

import 'package:codigo2_alerta2/widgets/colors.dart';
import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:codigo2_alerta2/widgets/textfield_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController dnicontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  bool isLoading = false;
  final formkey = GlobalKey<FormState>();

  Future login() async {
    if (formkey.currentState!.validate()) {
      ApiService apiService = ApiService();
      isLoading = true;
      setState(() {});
      UserModel? usermodel =
          await apiService.login(dnicontroller.text, passwordcontroller.text);
      if (usermodel != null) {
        print("Bienvenido ${usermodel.fullName}");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (rute) => false);
      } else {
        isLoading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: Colors.redAccent,
            content: Row(
              children: [
               const  Icon(Icons.error_outline),
                spaceWidth10,
                const Text("Hubo un error intelalo nuevamente")
              ],
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ExampleProvider exampleProvider = Provider.of<ExampleProvider>(context);

    return Scaffold(
      body: !isLoading
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsData.logo,
                              height: 20,
                            ),
                            spaceWidth6,
                            const Text(
                              "Alerta App",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.09),
                            )
                          ],
                        ),
                        space6,
                        Text("La vida es Bella",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kFontPrimaryColor.withOpacity(0.50))),
                        space30,
                        TextFieldCustomWidget(
                          controller: dnicontroller,
                          label: "Tu numero de DNI",
                          hintText: "Ingresa tu DNI",
                          inputTypeEnum: InputTypeEnum.dni,
                        ),
                        space30,
                        TextFieldCustomPasswordWidget(
                          hintText: "Tu contraseña",
                          label: "Ingresa tu contraseña",
                          inputTypeEnum: InputTypeEnum.text,
                          controller: passwordcontroller,
                        ),
                        space30,
                        ButtomCustomWidget(
                            text: "Iniciar Sesion",
                            onTap: () async {
                              //save2();
                              //login();
                              if (formkey.currentState!.validate()) {
                                ApiService apiService = ApiService();
                                isLoading = true;
                                setState(() {});
                                UserModel? usermodel = await apiService.login(
                                    dnicontroller.text,
                                    passwordcontroller.text);
                                if (usermodel != null) {
                                  print("Bienvenido ${usermodel.fullName}");
                                  exampleProvider.dni = usermodel.fullName;

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (rute) => false);
                                } else {
                                  isLoading = false;
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          backgroundColor: Colors.redAccent,
                                          content: Row(
                                            children: [
                                              Icon(Icons.error_outline),
                                              spaceWidth10,
                                             const  Text(
                                                  "Hubo un error intelalo nuevamente")
                                            ],
                                          )));
                                }
                              }
                            }),
                        space10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Aun no estas registrado?",
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.75),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                            spaceWidth6,
                            Text(
                              "Registrate",
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.75),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
