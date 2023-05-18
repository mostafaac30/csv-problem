import 'dart:io';
import 'package:fast_csv/fast_csv.dart' as fast_csv;

void main(List<String> args) {
  final inputFileName = args.isNotEmpty ? args[0] : null;

  if (inputFileName == null) {
    print('No input file name provided');
    return;
  }

  final inputFile = File(inputFileName);
  final csvData = inputFile.readAsStringSync();

  final productQuantities = <String, List<int>>{};
  final csvRows = fast_csv.parse(csvData);
  for (final row in csvRows) {
    // skip the header row
    if (row[0] == 'OrderID') {
      continue;
    }

    final productName = row[2].toString();
    final quantity = int.parse(row[3].toString());
    productQuantities.putIfAbsent(productName, () => []).add(quantity);
  }

  final productAverages = <String, double>{};
//   There are 4 orders for Intelligent Copper Knife products that total 12 items.
// ● There is 1 order for Small Granite Shoes totaling 4 items.
// There are 5 total orders, so the average per order is 12/5 = 2.4 for Intelligent Copper Knife,
// and 4/5 = 0.8 for Small Granite Shoes.

// product items count / total orders (records)
  productQuantities.forEach((productName, quantities) {
    final totalQuantity = quantities.reduce((a, b) => a + b);
    final averageQuantity = totalQuantity / csvRows.length;
    productAverages[productName] = averageQuantity;
  });

  final productBrands = <String, List<String>>{};
  for (final row in csvRows) {
    final productName = row[2].toString();
    final brand = row[4].toString();
    productBrands.putIfAbsent(productName, () => []).add(brand);
  }

  final productPopularBrands = <String, String>{};
  productBrands.forEach((productName, brands) {
    final brandCounts = <String, int>{};
    for (final brand in brands) {
      brandCounts[brand] = (brandCounts[brand] ?? 0) + 1;
    }
    final mostPopularBrand = brandCounts.keys.reduce((a, b) {
      return brandCounts[a]! >= brandCounts[b]! ? a : b;
    });
    productPopularBrands[productName] = mostPopularBrand;
  });

  final inputFileNameWithoutExtension =
      inputFileName.split(Platform.pathSeparator).last;

  final outputFile0 = File('0_$inputFileNameWithoutExtension');
  final outputFile1 = File('1_$inputFileNameWithoutExtension');

  final output0 = productAverages.entries
      .map((entry) => [entry.key, entry.value.toStringAsFixed(2)])
      .toList();

  output0.insert(0, ['Product', 'Average Quantity']);

  // convert to csv manually
  final output0Csv = output0.map((row) => row.join(',')).join('\n');

  final output1 = productPopularBrands.entries
      .map((entry) => [entry.key, entry.value])
      .toList();

  output1.insert(0, ['Product', 'Most Popular Brand']);

  final output1Csv = output1.map((row) => row.join(',')).join('\n');

  outputFile0.writeAsStringSync(output0Csv);
  outputFile1.writeAsStringSync(output1Csv);
}

/* TEST DATA*/

// 1001,New York,Shirt,2,Brand X
// 1002,Los Angeles,Shoes,1,Brand Y
// 1003,Chicago,Shirt,3,Brand X
// 1004,Houston,Shoes,2,Brand Z
// 1005,Miami,Pants,4,Brand X
// 1006,Seattle,Pants,2,Brand Y
// 1007,Dallas,Shirt,1,Brand Z
// 1008,New York,Shirt,2,Brand X
// 1009,Los Angeles,Shoes,1,Brand Z
// 1010,Chicago,Shirt,3,Brand Y
// 1011,Houston,Pants,2,Brand X
// 1012,Miami,Pants,4,Brand Y
// 1013,Seattle,Shirt,1,Brand Z
// 1014,Dallas,Shirt,2,Brand X
// 1015,New York,Shoes,1,Brand Z
// 1016,Los Angeles,Shirt,3,Brand Y
// 1017,Chicago,Shirt,2,Brand X
// 1018,Houston,Pants,2,Brand Z
// 1019,Miami,Pants,4,Brand X
// // 1020,Seattle,Shirt,1,Brand Y
// IDI,Minneapolis,shoes,2,Air
// ID2,Chicago,shoes,1,Air
// ID3,Central Department Store,shoes,5,BonPied
// ID4,Quail Hollow,forkst,3,Pfitzcraft