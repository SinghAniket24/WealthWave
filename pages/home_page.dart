import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sample data for Nifty50 chart
  final List<_ChartData> nifty50Data = [
    _ChartData('9:30', 18100),
    _ChartData('10:00', 18120),
    _ChartData('10:30', 18140),
    _ChartData('11:00', 18110),
    _ChartData('11:30', 18150),
    _ChartData('12:00', 18130),
  ];

  // Sample data for gainers and losers
  final List<Map<String, String>> gainers = [
    {"company": "Tata Motors", "price": "₹500", "change": "+5%"},
    {"company": "Reliance", "price": "₹2500", "change": "+3%"},
  ];
  final List<Map<String, String>> losers = [
    {"company": "Adani Power", "price": "₹230", "change": "-4%"},
    {"company": "Infosys", "price": "₹1200", "change": "-2%"},
  ];

  // Market statistics
  final Map<String, String> marketStats = {
    "Stocks Traded": "15,000",
    "52 Week High": "2,000",
    "52 Week Low": "1,500",
    "Upper Circuit": "300",
    "Lower Circuit": "250",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // // title: const Text("Stock Market Trends"),
      //   // // actions: [
      //   // //   IconButton(icon: const Icon(Icons.person), onPressed: () {}),
      //   // ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search stocks...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nifty50 Overview
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nifty50 Overview",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Day Change: +120 points (+0.66%)",
                        style: TextStyle(color: Colors.green),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            LineSeries<_ChartData, String>(
                              dataSource: nifty50Data,
                              xValueMapper: (_ChartData data, _) => data.time,
                              yValueMapper: (_ChartData data, _) => data.value,
                              color: Colors.blue,
                              width: 2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Gainers and Losers Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Gainers Section
                  Expanded(
                    child: _StockSection(
                      title: "Top Gainers",
                      stocks: gainers,
                      seeMore: true,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Losers Section
                  Expanded(
                    child: _StockSection(
                      title: "Top Losers",
                      stocks: losers,
                      seeMore: true,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Market Statistics Section
              const Text(
                "Market Statistics",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Updated: ${DateTime.now().toLocal()}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _MarketStatTile(
                            title: "Stocks Traded",
                            value: marketStats["Stocks Traded"]!,
                          ),
                          _MarketStatTile(
                            title: "52 Week High",
                            value: marketStats["52 Week High"]!,
                          ),
                          _MarketStatTile(
                            title: "52 Week Low",
                            value: marketStats["52 Week Low"]!,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _MarketStatTile(
                            title: "Upper Circuit",
                            value: marketStats["Upper Circuit"]!,
                          ),
                          _MarketStatTile(
                            title: "Lower Circuit",
                            value: marketStats["Lower Circuit"]!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for Gainers/Losers Section
class _StockSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> stocks;
  final bool seeMore;
  final Color color;

  const _StockSection({
    required this.title,
    required this.stocks,
    this.seeMore = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            ...stocks.map((stock) {
              return ListTile(
                title: Text(stock['company']!),
                subtitle: Text(stock['price']!),
                trailing: Text(
                  stock['change']!,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
            if (seeMore)
              TextButton(
                onPressed: () {},
                child: const Text("See More"),
              ),
          ],
        ),
      ),
    );
  }
}

// Widget for Market Statistics Tile
class _MarketStatTile extends StatelessWidget {
  final String title;
  final String value;

  const _MarketStatTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }
}

// Class for chart data
class _ChartData {
  final String time;
  final double value;

  _ChartData(this.time, this.value);
}
