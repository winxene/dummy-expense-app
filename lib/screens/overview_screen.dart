// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../widgets/buttons/change_theme_button.dart';
import '../../widgets/overview_screen_widgets/month_spending_card.dart';
import '../../providers/transaction_provider.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Personal Expenses 💰'),
        actions: <Widget>[ChangeThemeButton()],
      ),
      body: FutureBuilder<void>(
          future: context.read<TransactionProvider>().getSpendingSum(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred: ${snapshot.error}'),
              );
            } else {
              return Consumer<TransactionProvider>(
                builder: (ctx, provider, child) {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, //200 is the width of the item
                      childAspectRatio: 3 / 2, //height/width
                      crossAxisSpacing: 20, //space between items
                      mainAxisSpacing: 20, //space between lines
                    ),
                    children: provider.monthlyTransactionSummaries
                        .map((provider) => MonthSpendingCard(
                              provider['month'],
                              provider['amount'],
                            ))
                        .toList(),
                  );
                },
              );
            }
          }),
    );
  }
}
