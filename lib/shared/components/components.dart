import 'package:flutter/material.dart';

//------------------------------------------------------
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );
// Widget buildListProduct(context) =>
//     Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListView.separated(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemBuilder: (context, index) => Container(
//                   child: Row(
//                     children: [
//                       Stack(
//                         alignment: AlignmentDirectional.bottomEnd,
//                         children: [
//                           CircleAvatar(
//                             radius: 30.0,
//                             backgroundImage: NetworkImage(
//                                 'https://avatars.githubusercontent.com/u/34492145?v=4'),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 20.0,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(
//                               height: 5.0,
//                             ),
//                             Row(
//                               children:
//                               [
//                                 Expanded(
//                                   child: Text(
//                                     'hello my name is abdullah ahmed hello my name is abdullah ahmed',
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10.0,
//                                   ),
//                                   child: Container(
//                                     width: 7.0,
//                                     height: 7.0,
//                                     decoration: BoxDecoration(
//                                       color: Colors.blue,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   '02:00 pm',
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//               ),
//               separatorBuilder: (context, index) => SizedBox(
//                 height: 30.0,
//               ),
//               itemCount: 10,
//             ),
//           ],
//         ),
//       ),
//     );
