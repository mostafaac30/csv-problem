Order Processing Program
========================

This program processes order data and calculates product averages and determines the most popular brands. It reads a CSV file containing order information, performs the required calculations, and generates output files.

Prerequisites
-------------

*   Dart SDK: Make sure you have Dart SDK installed on your machine. You can download it from the official Dart website: [https://dart.dev/get-dart](https://dart.dev/get-dart)

Installation
------------

1.  Clone the repository or download the source code files.
2.  Open a terminal and navigate to the project directory.

Usage
-----

1.  Prepare your order data in a CSV file. The CSV file should have the following columns: OrderID, DeliveryArea, ProductName, Quantity, Brand. Each row represents an order.
    
2.  Run the program using the Dart SDK by executing the following command in the terminal:
    
    cssCopy code
    
    `dart csv_problem.dart" assets/data.csv`
    
    Replace `<assets/data.csv>` with the path to your input CSV file.
    
3.  The program will process the order data and generate two output files: `0_<input_file_name>` and `1_<input_file_name>`. These files will contain the calculated product averages and the most popular brands, respectively.
    
4.  Locate the output files in the same directory as the input CSV file.
    

Example
-------

Suppose you have an input CSV file named `orders.csv` with the following contents:


`OrderID,DeliveryArea,ProductName,Quantity,Brand 1001,New York,Shirt,2,Brand X 1002,Los Angeles,Shoes,1,Brand Y 1003,Chicago,Shirt,3,Brand X 1004,Houston,Shoes,2,Brand Z`

To process the orders and generate the output files, run the following command:


`dart main.dart orders.csv`

After execution, you will find two output files: `0_orders.csv` and `1_orders.csv`. These files will contain the calculated product averages and the most popular brands, respectively.

Notes
-----

*   Make sure the input CSV file is properly formatted with the correct column order and headers.
*   The program uses the `fast_csv` package for CSV parsing. If it's not already installed, the program will automatically download and install it during the first run.

If you encounter any issues or have questions, please feel free to contact the author of this program.
