// import 'package:flutter/material.dart';
// import 'package:flutter_mvvm_project/presentation/src/space_manager.dart';
// import 'package:flutter_mvvm_project/presentation/src/values_manager.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../domain/models.dart';

// class OnboardingBody extends StatelessWidget {
//   const OnboardingBody({super.key, required this.sliderObject});
//   final SliderObject sliderObject;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppSize.s8),
//       child: Column(
//         children: [
//           BuildSpace.virtical(AppSize.s40),
//           Text(
//             sliderObject.title,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.headline1,
//           ),
//           Text(
//             sliderObject.subTitle,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           BuildSpace.virtical(AppSize.s40),
//           SvgPicture.asset(sliderObject.image),
//         ],
//       ),
//     );
//   }
// }
