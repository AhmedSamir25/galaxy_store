import 'package:fashionstown/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fashionstown/core/theme/text_style.dart';
import 'package:fashionstown/core/utils/widgets/custom_button_icon.dart';
import 'package:fashionstown/core/utils/widgets/custom_loading.dart';
import 'package:fashionstown/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:fashionstown/features/home/presentation/manager/cubit/product_cubit.dart';

class LatesArrivalList extends StatefulWidget {
  const LatesArrivalList({Key? key}) : super(key: key);

  @override
  State<LatesArrivalList> createState() => _LatesArrivalListState();
}

class _LatesArrivalListState extends State<LatesArrivalList> {
  @override
  Widget build(BuildContext context) {
    double widthMedia = MediaQuery.of(context).size.width;
    double heightMedia = MediaQuery.of(context).size.height;
    final productCubit = BlocProvider.of<ProductCubit>(context);
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductDataSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: backgroundColorItem,
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: widthMedia * 0.23),
                            // Name
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                "${productCubit.products[index].productName}",
                                style: TextStyles.textStyle14.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          Row(
                            children: [
                              CusttomIconButton(
                                colorIcon: Colors.black,
                                onPressed: () {},
                                icon: const Icon(FontAwesomeIcons.heart),
                              ),
                              CusttomIconButton(
                                colorIcon: cartCubit.isProductsInCart(
                                        productId: productCubit
                                            .products[index].productId
                                            .toString())
                                    ? appColor
                                    : highlightColor,
                                onPressed: () {
                                  cartCubit.addCart(
                                    productId:
                                        "${productCubit.products[index].productId}",
                                    productName:
                                        "${productCubit.products[index].productName}",
                                    productImage:
                                        "${productCubit.products[index].productImage}",
                                    productPrice:
                                        "${productCubit.products[index].productPrice}",
                                    productCategory:
                                        "${productCubit.products[index].productCategory}",
                                    productCount: 1,    
                                  );
                                  BlocProvider.of<CartCubit>(context)
                                      .getCartData();
                                  setState(() {});
                                },
                                icon: cartCubit.isProductsInCart(
                                        productId: productCubit
                                            .products[index].productId
                                            .toString())
                                    ? const Icon(Icons.shopping_cart)
                                    : const Icon(Icons.add_shopping_cart),
                              ),
                            ],
                          ),
                          Text(
                            "${productCubit.products[index].productPrice}\$",
                            style: TextStyles.textStyle18,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: widthMedia * 0.04,
                      ),
                      Image.network(
                        ("${productCubit.products[index].productImage}"),
                        fit: BoxFit.fill,
                        width: widthMedia * 0.25,
                        height: heightMedia * 0.17,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: productCubit.products.length,
            scrollDirection: Axis.horizontal,
          );
        } else if (state is FieldGetProductData) {
          return Text(state.massage);
        } else {
          return ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: widthMedia * 0.60,
                child: const LoadingShimmer(),
              );
            },
          );
        }
      },
    );
  }
}