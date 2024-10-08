import 'package:flutter/material.dart';

class WaterTradingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Trading'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buy & Sell Water Instantly',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildDashboard(context),
              SizedBox(height: 20.0),
              _buildTradeSection(context),
              SizedBox(height: 20.0),
              Text(
                'Trade History',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildTradeHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOverviewCard('Available Water to sell', '2,478L', Icons.water, Colors.blue[800]!),
                _buildOverviewCard('Total Sales', 'R52,478.90', Icons.attach_money, Colors.green[800]!),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOverviewCard('Open Trades', '3', Icons.swap_horiz, Colors.orange[800]!),
                _buildOverviewCard('Pending Bids', '5', Icons.pending, Colors.red[800]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String amount, IconData icon, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 40.0),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Text(
                amount,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTradeSection(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Make a Trade',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuyPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    child: Text('Buy Water'),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SellPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    child: Text('Sell Water'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeHistory() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('100L - R50'),
              subtitle: Text('Bought on 13/07/2024'),
              trailing: Icon(Icons.history),
            ),
            ListTile(
              title: Text('200L - R90'),
              subtitle: Text('Sold on 14/07/2024'),
              trailing: Icon(Icons.history),
            ),
            // Additional trade history...
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Filter history action
              },
              child: Text('Filter by Date'),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyPage extends StatefulWidget {
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  List<Seller> _sellers = [
    Seller('Masibonge Shabalala', '110L', 'R45.00', '4.5', 'Gauteng', 10),
    Seller('Simon Ndlovu', '20L', 'R90.00', '4.7', 'Pretoria', 9),
    Seller('Timelyin Abiodun', '190L', 'R45.00', '4.5', 'Gauteng', 6),
    Seller('Nthabiseng Sedisha', '200L', 'R87.00', '4.7', 'Pretoria', 21),
    Seller('Zama Xulu', '110L', 'R45.00', '4.5', 'KwaGuqa', 10),
    Seller('Twarisani Nxumalo', '1000L', 'R900.00', '4.7', 'Ladysmith', 29),
    // Additional sellers...
  ];

  List<Seller> _filteredSellers = [];

  String _filterCriteria = 'price';
  String _filterValue = '';

  @override
  void initState() {
    super.initState();
    _filteredSellers = _sellers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Water'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Filter',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _filterValue = value;
                        _filterSellers();
                      });
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: _filterCriteria,
                  onChanged: (String? value) {
                    setState(() {
                      _filterCriteria = value ?? 'price';
                      _filterSellers();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Price'),
                      value: 'price',
                    ),
                    DropdownMenuItem(
                      child: Text('Quantity'),
                      value: 'quantity',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredSellers.length,
                itemBuilder: (context, index) {
                  return _buildBuyerListTile(context, _filteredSellers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuyerListTile(BuildContext context, Seller seller) {
    return ListTile(
      title: Text(seller.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${seller.waterCredit} - Price: ${seller.price}'),
          Text('Rating: ${seller.rating} | Location: ${seller.location}'),
          Text('Trades: ${seller.trades}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              _showBuyDialog(context, seller);
            },
            child: Text('Buy'),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              _showBidDialog(context, seller);
            },
            child: Text('Bid'),
          ),
        ],
      ),
    );
  }

  void _filterSellers() {
    setState(() {
      _filteredSellers = _sellers
          .where((seller) => _filterCriteria == 'price'
          ? seller.price.contains(_filterValue)
          : seller.waterCredit.contains(_filterValue))
          .toList();
    });
  }

  void _showBuyDialog(BuildContext context, Seller seller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.person, size: 30.0, color: Colors.grey[800]),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(seller.name, style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white, size: 16.0),
                              SizedBox(width: 4.0),
                              Text(seller.location, style: TextStyle(color: Colors.white, fontSize: 14.0)),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Text('Trades: ${seller.trades}', style: TextStyle(color: Colors.white, fontSize: 14.0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/backgroundimg.jpeg'),
                    ),
                    SizedBox(height: 10.0),
                    Text('Water Credit', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    Text('${seller.waterCredit}', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    Text('Price: ${seller.price}', style: TextStyle(fontSize: 16.0, color: Colors.grey[700])),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Action to buy water.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 15, 92, 224),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Buy', style: TextStyle(fontSize: 18.0),),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }

  void _showBidDialog(BuildContext context, Seller seller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Place Your Bid'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Seller: ${seller.name}'),
              Text('Water Credit: ${seller.waterCredit}'),
              Text('Min Bid: ${seller.price}'),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bid Amount',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Action to place the bid.
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Place Bid', style: TextStyle(fontSize: 18.0)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Seller {
  final String name;
  final String waterCredit;
  final String price;
  final String rating;
  final String location;
  final int trades;

  Seller(this.name, this.waterCredit, this.price, this.rating, this.location, this.trades);
}

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  List<Trade> _tradeHistory = [
    Trade(quantity: 20.0, price: 'R60.00', buyerName: 'Alice', review: 'Smooth transaction'),
    Trade(quantity: 15.0, price: 'R45.00', buyerName: 'Bob', review: 'Quick and easy'),
  ];

  List<Bid> _currentBids = [
    Bid(quantity: 10.0, price: 'R25.00', buyerName: 'Charlie'),
    Bid(quantity: 5.0, price: 'R12.50', buyerName: 'David'),
  ];

  double _waterCredit = 100.0; // Example starting water credit
  String _waterPrice = 'R50.00'; // Example price
  double _sellQuantity = 0.0; // Quantity to sell

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      appBar: AppBar(
        title: Text('Sell Water'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current Balance Display
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Text(
                    '$_waterCredit',
                    style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'Current water available to sell (Liters)',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            // Payment Method Selection Tabs
            
            SizedBox(height: 20.0),

            // Sell Water Button
            ElevatedButton(
              onPressed: _showSellDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Sell Water', style: TextStyle(fontSize: 18.0)),
            ),
            SizedBox(height: 20.0),

            // Current Bids Section
            _buildCurrentBidsSection(),
            SizedBox(height: 20.0),

            // Trade History Section
            _buildTradeHistorySection(),
          ],
        ),
      ),
    );
  }

  // Build Payment Method Button
  Widget _buildPaymentMethodButton(String title, bool isSelected) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        padding: EdgeInsets.symmetric(vertical: 110.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentBidsSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Bids:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          _currentBids.isEmpty
              ? Text('No current bids.')
              : Expanded(
                  child: ListView.builder(
                    itemCount: _currentBids.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text('Bid: ${_currentBids[index].price} for ${_currentBids[index].quantity}L'),
                          subtitle: Text('From: ${_currentBids[index].buyerName}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              _acceptBid(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: Text('Accept'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTradeHistorySection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trade History:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          _tradeHistory.isEmpty
              ? Text('No trades yet.')
              : Expanded(
                  child: ListView.builder(
                    itemCount: _tradeHistory.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text('${_tradeHistory[index].quantity}L sold for ${_tradeHistory[index].price}'),
                          subtitle: Text('Buyer: ${_tradeHistory[index].buyerName} | Review: ${_tradeHistory[index].review}'),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _showSellDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Water Price and Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price per Liter (R)',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _waterPrice = 'R$value';
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity (L)',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _sellQuantity = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Add blockchain integration to record the sell order
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: Text('Set Price and Quantity'),
            ),
          ],
        );
      },
    );
  }

  void _acceptBid(int index) {
    // Logic to accept bid and update blockchain transaction
    setState(() {
      _waterCredit -= _currentBids[index].quantity;
      _tradeHistory.add(Trade(
        quantity: _currentBids[index].quantity,
        price: _currentBids[index].price,
        buyerName: _currentBids[index].buyerName,
        review: 'No review yet',
      ));
      _currentBids.removeAt(index);
    });
  }
}

class Trade {
  final double quantity;
  final String price;
  final String buyerName;
  final String review;

  Trade({required this.quantity, required this.price, required this.buyerName, required this.review});
}

class Bid {
  final double quantity;
  final String price;
  final String buyerName;

  Bid({required this.quantity, required this.price, required this.buyerName});
}