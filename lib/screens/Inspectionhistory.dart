import 'package:final_year/functions/functions.dart';
import 'package:final_year/screens/inspection_details.dart';
import 'package:final_year/utils/app_colors.dart';
import 'package:flutter/material.dart';

class InspectionHistory extends StatefulWidget {
  const InspectionHistory({super.key});

  @override
  State<InspectionHistory> createState() => _InspectionHistoryState();
}

class _InspectionHistoryState extends State<InspectionHistory> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allItems = [];
  List<String> _filteredItems = [];
  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _filterItems(String query) {
    List<String> filteredList = _allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredItems = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Inspection History'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (query) => _filterItems(query),
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: const Color(0xffE8F2EC),
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffE8F2EC)),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffE8F2EC)),
                    borderRadius: BorderRadius.circular(15)),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Total Inspection 04',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: FutureBuilder(
                  future: Functions.getHistory(1),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xff2CAD5E),
                      ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return HistoryTile(snapshot.data[index]);
                          });
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  }),
            ),
            // Expanded(
            //   child: _filteredItems.isNotEmpty
            //       ? ListView.builder(
            //           itemCount: _filteredItems.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               title: Text(_filteredItems[index]),
            //             );
            //           },
            //         )
            //       : ListView(
            //           children: [

            //           ],
            //         ),
            // ),
          ],
        ),
      )),
    );
  }

  Widget HistoryTile(data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return InspectionDetails(
              data: data,
            );
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  // margin: const EdgeInsets.only(bottom: 25),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: AppColors.appGreen,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Inspection ${data['name']}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'score ${data['score']}',
                      style: TextStyle(color: Colors.orange),
                    )
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 181, 121, 0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Details',
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      ),
    );
  }
}
