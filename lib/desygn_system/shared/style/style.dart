import 'package:dev/desygn_system/shared/color/colors.dart'; // Importe suas cores
import 'package:flutter/material.dart';

// Sugestão: Defina um fontFamily padrão se você estiver usando um customizado
// const String kDefaultFontFamily = 'Inter'; // Exemplo, se você tiver a fonte 'Inter'

// Base Style (opcional, para reduzir repetição se muitos estilos compartilharem propriedades)
// TextStyle _kBaseTextStyle = const TextStyle(
//   fontFamily: kDefaultFontFamily, // Descomente se usar um fontFamily padrão
//   fontWeight: FontWeight.normal,
//   color: kFontColorBlack,
// );

TextStyle headingStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle subHeadingStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle titleStyle = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle subTitleStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle buttonStyle1 = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kFontColorWhite, // Usando a constante
);

TextStyle buttonStyle2 = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle textFieldStyle = const TextStyle(
  fontSize: 16,
  // fontWeight: FontWeight.normal, // Considerar se o bold é realmente necessário aqui
  color: kFontColorBlack, // Usando a constante
);

TextStyle errorStyle = const TextStyle(
  fontSize: 14,
  fontWeight:
      FontWeight.bold, // Ou talvez FontWeight.w500 para não ser tão forte
  color: appRedColor, // Usando sua constante de cor vermelha
);

TextStyle successStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: appGreenColor, // Usando sua constante de cor verde
);

TextStyle infoStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kBlueColor, // Usando sua constante de cor azul
);

TextStyle warningStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kYellowColor, // Usando sua constante de cor amarela
);

TextStyle normalStyle = const TextStyle(
  fontSize: 14,
  // fontWeight: FontWeight.normal, // O normal é geralmente sem bold
  color: kFontColorBlack, // Usando a constante
);

TextStyle smallStyle = const TextStyle(
  fontSize: 12,
  // fontWeight: FontWeight.normal, // O small geralmente é mais leve
  color: kFontColorBlack, // Usando a constante
);

// Se a fonte 'Inter' for de fato usada, certifique-se de que ela está configurada no pubspec.yaml
// e que os pesos de fonte (w600, w500) estão disponíveis.
const TextStyle button2Semibold = TextStyle(
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w600, // FontWeight.w600 é Semibold
  color: appRedColor, // Usando sua constante de cor vermelha
);

const TextStyle label2Semibold = TextStyle(
  fontFamily: 'Inter',
  fontSize: 10,
  height: 1.6, // height é geralmente um multiplicador (ex: 16/10 = 1.6)
  fontWeight:
      FontWeight
          .w500, // FontWeight.w500 é Medium (ou Semibold, dependendo da fonte)
  color: appRedColor, // Usando sua constante de cor vermelha
);
