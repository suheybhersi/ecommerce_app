import 'package:ecommerce_app/components/my_button.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/shop.dart';
import 'package:ecommerce_app/themes/light_mode.dart';
import 'package:ecommerce_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Remove from cart?'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<Shop>().removeFromCart(product);
              context.read<Shop>().total =
                  context.read<Shop>().total - product.price;
            },
            child: const Text('Yes'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Please select payment method'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              paymentSuccessful(context);
            },
            child: const Text('Pay'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void paymentSuccessful(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Payment Successful!'),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<Shop>().emptyCart();
              context.read<Shop>().total = 0.0;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/shop_page',
                (route) => false,
              );
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    final total = context.watch<Shop>().total;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cart'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(listen: false, context).toggleTheme();
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                Provider.of<ThemeProvider>(context).themeData == lightMode
                    ? Icons.dark_mode
                    : Icons.light_mode_outlined,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty...'))
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];

                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text(item.price.toStringAsFixed(2)),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => removeItemFromCart(context, item),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      MyButton(
                        onTap: () => payButtonPressed(context),
                        child: const Text('PAY NOW'),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
