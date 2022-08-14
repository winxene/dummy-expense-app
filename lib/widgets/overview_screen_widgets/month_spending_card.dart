import 'package:flutter/material.dart';
import '../../screens/transaction_detail_screen.dart';

class MonthSpendingCard extends StatefulWidget {
  final String month;
  final int? spending;

  // ignore: use_key_in_widget_constructors
  const MonthSpendingCard(this.month, this.spending);

  @override
  // ignore: library_private_types_in_public_api
  _MonthSpendingCardState createState() => _MonthSpendingCardState();
}

class _MonthSpendingCardState extends State<MonthSpendingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailScreen(
              month: widget.month,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.month,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
                decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Spending',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.spending == null ? 'Rp.0' : 'Rp. ${widget.spending}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
