import 'package:fashionstown/core/router/app_router.dart';
import 'package:fashionstown/core/shared/theme_mode.dart';
import 'package:fashionstown/core/theme/colors.dart';
import 'package:fashionstown/core/utils/widgets/add_cart_button.dart';
import 'package:fashionstown/core/utils/widgets/add_favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashionstown/core/theme/text_style.dart';
import 'package:fashionstown/core/utils/widgets/custom_loading.dart';
import 'package:fashionstown/features/home/presentation/manager/cubit/product_cubit.dart';
import 'package:go_router/go_router.dart';

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

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductDataSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(
                    AppRouter.homeDetailsView,
                    extra: productCubit.products[index].productId,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: SaveThemeMode().getTheme()
                          ? backgroundColorItemDark
                          : backgroundColorItemLight,
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
                                AddFavoriteButton(
                                  productCategory: "${productCubit.products[index].productCategory}",
                                  productId: "${productCubit.products[index].productId}",
                                  productImage: "${productCubit.products[index].productImage}",
                                  productName: "${productCubit.products[index].productName}",
                                  productPrice: "${productCubit.products[index].productPrice}",
                                ),
                                AddCartButton(
                                  productId: "${productCubit.products[index].productId}",
                                   productImage: "${productCubit.products[index].productImage}",
                                    productName: "${productCubit.products[index].productName}",
                                     productPrice: "${productCubit.products[index].productPrice}", 
                                     productCategory: "${productCubit.products[index].productCategory}")
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
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: widthMedia * 0.25,
                            height: heightMedia * 0.17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${productCubit.products[index].productImage}"),
                                fit: BoxFit.fill,
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
