

// هنا ده بيسمع علي اي حاجه في ال home_layout وبيتغير علي طول
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/product/cubit/cubit.dart';
import '../../layout/product/cubit/states.dart';
import '../../shared/components/components.dart';

class OrderScreen extends StatelessWidget
{
  List<TextEditingController> _controllers = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        ProductCubit cubit = ProductCubit.get(context);
        List data =[];
        cubit.OrderList.forEach((k,v) => data.add(v));
        int TotalCost = 0 ;
        cubit.FNumber.forEach((k,v) => TotalCost =TotalCost +int.parse(v));
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text("Order"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(TotalCost.toString()),
              ),
              SizedBox(width: 100,),
              IconButton(
                icon: CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.add,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate())
                  {
                    // Add Code
                  }else{
                    print("asa");
                  }


                  // for(int x =0 ;x<data.length ;x++){
                  //   if(cubit.FNumber[x] ==null ){
                  //     //showAlertDialog(context);
                  //     return ;
                  //   }else{
                  //     // cubit.AddOrder(
                  //     //     NumberOrder: cubit.numberOrder.toString(),
                  //     //     name: data[x][1].toString(),
                  //     //     number: cubit.FNumber[x].toString(),
                  //     //     cost: (int.parse(cubit.FNumber[x])*int.parse(data[x][3])).toString(),
                  //     //     Finalcost: cubit.FinalCost.toString());
                  //   }
                  // }
                  // _controllers = [];
                  // cubit.FNumber.clear();
                  // cubit.changeNumberOrder();
                  // cubit.OrderList.clear();
                  // data.clear();
                  // cubit.changeIndex(0);
                },
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: data.length != 0,
            builder: (context) => Container(
              child: Form(
                key: formKey,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      _controllers.add(new TextEditingController());
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(data[index][1].toString(),
                                    style:TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),),
                                ),
                                Expanded(
                                  child: Text(data[index][2].toString(),
                                    style:TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),),
                                ),
                                Expanded(
                                  child: Text(data[index][3].toString(),
                                    style:TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    width: 10,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,

                                      onChanged: (value){
                                         int cost = int.parse(value) * int.parse(data[index][3]) ;
                                        cubit.changeFNumber(cost.toString(),index);
                                      },
                                      controller: _controllers[index],
                                      cursorColor: Colors.pink,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Type must not be empty';
                                        }
                                        return null;
                                      },

                                      style: TextStyle(fontSize: 20, height: 0.5 ,color: Colors.pink),
                                      decoration: InputDecoration(
                                        labelText: 'Number',
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 10),
                                        hintText: 'Number',
                                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10),
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    itemCount: data.length),
              ),
            ),
            fallback: (context) => Center(child: Text("اختار منتج ",
              style:TextStyle(color: Colors.purpleAccent, fontSize: 50, fontWeight: FontWeight.bold),),
            ),
          ),
        );
      },
    );
  }
}