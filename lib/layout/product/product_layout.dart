
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ProductLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController _type = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _number = new TextEditingController();
  TextEditingController _price = new TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => ProductCubit()..createDatabase(),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (BuildContext context, ProductStates state) {
          if(state is AppInsertDatabaseState)
          {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, ProductStates state) {
          ProductCubit cubit = ProductCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            // appBar: AppBar(
            //   title: Text(
            //     cubit.titles[cubit.currentIndex],
            //   ),
            // ),
            body: ConditionalBuilder(
              condition: state is ProductInitialState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => cubit.screens[cubit.currentIndex],
              //fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Order',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown)
                {
                  if (formKey.currentState!.validate())
                  {
                    cubit.AddData(
                        type: _type.text,
                        name: _name.text,
                        number: _number.text,
                        salary: _price.text);
                  }
                }
                else {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        20.0,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              controller: _type,
                              onChange: (){},
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Type must not be empty';
                                }
                                return null;
                              },
                              label: 'Product Type',
                              prefix: Icons.merge_type,
                            ),

                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: _name,
                              onChange: (){},
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Name must not be empty';
                                }
                                return null;
                              },
                              label: 'Product Name',
                              prefix: Icons.drive_file_rename_outline,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: _number,
                              onChange: (){},
                              type: TextInputType.number,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Product must not be empty';
                                }
                                return null;
                              },
                              label: 'Product Number',
                              prefix: Icons.confirmation_number,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: _price,
                              onChange: (){},
                              type: TextInputType.number,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Price must not be empty';
                                }
                                return null;
                              },
                              label: 'Product Price',
                              prefix: Icons.monetization_on,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  ).closed.then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
          );
        },
      ),
    );
  }
}
