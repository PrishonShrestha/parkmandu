import 'package:flutter/material.dart';

class ParkingHistory extends StatelessWidget {
  ParkingHistory({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(
        title: Text("Parking history"),
        centerTitle: true,
        backgroundColor: Color(0xFFADD8E6),
      ),
      body: Container(
        height: size.height,
        width: size.width,

        child: Column(
          children: [
            TextField(
              //controller: _searchController,
              decoration: InputDecoration(labelText: 'Enter country name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                /*String query = _searchController.text;
                await _countryController.search(query);*/
                // Update UI with search results
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  //CountryModel country = _countryController.searchResults[index];
                  return ListTile(
                    title: Text("Hello"),
                    subtitle: Text("HI"),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
