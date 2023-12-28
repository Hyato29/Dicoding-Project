import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Restaurant App",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Versi 3.0", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 15,
            ),
            const Icon(
              Icons.restaurant_menu,
              color: Colors.amber,
              size: 80,
            ),
            const SizedBox(
              height: 15,
            ),
            Text("@ 2023 - 2024 Restaurant Ing.",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text("Lisensi",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
