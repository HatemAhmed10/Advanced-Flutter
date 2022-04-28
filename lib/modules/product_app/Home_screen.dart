import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:pharmacy_manager2/shared/components/components.dart';
import 'package:pharmacy_manager2/shared/cubit/cubit.dart';
import 'package:pharmacy_manager2/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/product/cubit/cubit.dart';
import '../../layout/product/cubit/states.dart';


// هنا ده بيسمع علي اي حاجه في ال home_layout وبيتغير علي طول
class HomeScreen extends StatelessWidget
{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController _type = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _number = new TextEditingController();
  TextEditingController _price = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
         ProductCubit cubit = ProductCubit.get(context);
        // ignore: prefer_typing_uninitialized_variables
         List<Map> Data = ProductCubit.get(context).TypeProduct ;
         List<Map> Data2 = ProductCubit.get(context).AllTypeData ;

        return Scaffold(
          key: scaffoldKey,
          //backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text(
              "المدير ",
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style:TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.perm_device_information,
                    size: 30.0,
                    color: Colors.pink,
                  ),
                ),
                onPressed: () {
                  //cubit.GetAllOrder(cubit.database);
                  // navigateTo(
                  //   context,
                  //   Information(),
                  // );
                },
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: Data.isNotEmpty,
            builder: (context) => Container(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.GetOneData(
                                      database: cubit.database,
                                      type: Data[index]["P_type"].toString());
                                },
                                child: Text(
                                  Data[index]["P_type"].toString(),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style:TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              )
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.0,
                          ),
                          itemCount: Data.length),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      color: Colors.black87,
                      child: ListView.separated(
                          itemBuilder:  (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Container(
                                //color: Colors.pink,
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                          if (states.contains(MaterialState.focused))
                                            return Colors.red;
                                          if (states.contains(MaterialState.hovered))
                                            return Colors.green;
                                          if (states.contains(MaterialState.pressed))
                                            return Colors.pink;
                                          return Colors.transparent; // Defer to the widget's default.
                                        }),
                                  ),
                                  onPressed: () {
                                    cubit.AddArray(index);
                                    //print(cubit.OrderList.toString());
                                  },
                                  child:Text(Data2[index]['P_name'].toString(),
                                    style:TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),),
                                ),
                              ),

                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.0,
                          ),
                          itemCount: Data2.length
                      ),
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(
                child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}