import 'package:flutter/material.dart';
import 'package:htp/models/productmodel.dart';
import 'package:htp/repository/detailed.dart';
import 'package:htp/repository/fetch_product_repo.dart';

class FetchProduct extends StatefulWidget {
  const FetchProduct({super.key});

  @override
  State<FetchProduct> createState() => _FetchProductState();
}

class _FetchProductState extends State<FetchProduct> {
  late Future<List<Products>> futureProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureProducts = ProductRepo().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     ProductRepo().addProduct(
            //       category: 'ROG',
            //       description: 'Laptop',
            //       price: 120,
            //       title: 'gaming',
            //       image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
            //       rating: {"value":3.5,
            //       "count":150
            //       }
            //     );
            //   },
            //   icon: const Icon(Icons.add),
            // )
          ],
        ),
        body: FutureBuilder<List<Products>>(
          future: futureProducts,
          builder: (context, snapshot) {
            print(snapshot.hasData);
            if (snapshot.hasData) {
              var productData = snapshot.data;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 400,
                  childAspectRatio: 2 / 2,
                ),
                itemCount: productData!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Detail(prodetails: productData[index]),
                        )),
                    child: Card(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(
                              child: Image.network(
                                productData[index].image!,
                                width: 200,
                                height: 180,
                                // fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text(productData[index].title!),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(productData[index]
                                        .rating!
                                        .rate
                                        .toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          ProductRepo().updateProduct(
                                            id: productData[index]
                                                .id
                                                .toString(),
                                            title: productData[index].title,
                                            price: productData[index]
                                                .price
                                                .toString(),
                                          );
                                        },
                                        child: const Text('Update')),
                                    TextButton(
                                        onPressed: () {
                                          ProductRepo().deleteProduct(
                                            id: productData[index].id.toString()
                                          );
                                        },
                                        child: Text('Delete'))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
