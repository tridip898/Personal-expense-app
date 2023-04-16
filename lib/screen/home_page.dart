import 'package:flutter/material.dart';
import 'package:personnel_expense_app/widget/add_new_transaction.dart';
import 'package:personnel_expense_app/widget/charts.dart';
import 'package:personnel_expense_app/widget/transaction_list.dart';

import '../model/transaction_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  final List<TransactionModel> _transaction = [
    TransactionModel(
        id: "1", title: "Buying Shoes", amount: 109.99, date: DateTime.now()),
    // TransactionModel(
    //     id: "2", title: "Internet Bill", amount: 56.49, date: DateTime.now()),
    // TransactionModel(
    //     id: "3", title: "Restaurant Bill", amount: 89.00, date: DateTime.now()),
    // TransactionModel(
    //     id: "4", title: "Transportation", amount: 76.89, date: DateTime.now()),
    // TransactionModel(
    //     id: "5", title: "Shopping", amount: 159.25, date: DateTime.now()),
  ];

  List<TransactionModel> get _recentTransaction{
    return _transaction.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosendate) {
    final newTx = TransactionModel(
        title: txTitle,
        amount: txAmount,
        date: chosendate,
        id: DateTime.now().toString());

    setState(() {
      _transaction.add(newTx);
    });
  }


  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
            onTap: (){},
            child: AddTransaction(addTx: _addNewTransaction),
            behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  Widget _buildLandscapeContent(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Show Chart",style: TextStyle(fontSize: 22,color: Colors.grey),),
        Switch(value: _value, onChanged: (val){
          setState(() {
            _value=val;
          });
        })
      ],
    );
  }

  Widget _buildPotraitContent(MediaQueryData deviceSize,AppBar appBar){
    return Container(
        height: (deviceSize.size.height - appBar.preferredSize.height-deviceSize.padding.top)*0.3,
        child: Charts(recentTransaction: _recentTransaction,));
  }

  bool _value=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context);
    final textSize=MediaQuery.of(context).textScaleFactor;

    final isLandScape=deviceSize.orientation == Orientation.landscape;
    final appBar= AppBar(
      title: Text(
        "Personnel Expense",
        style: TextStyle(fontSize: 20 * textSize),
      ),
      centerTitle: false,
      actions: [
        IconButton(onPressed:()=> _startAddNewTransaction(context), icon: Icon(Icons.add,size: 30,color: Colors.white,))
      ],
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        floatingActionButton: FloatingActionButton(
            onPressed: ()=> _startAddNewTransaction(context),
          child: Icon(Icons.add,size: 40,),
          backgroundColor: Colors.red,
          elevation: 5,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(isLandScape) _buildLandscapeContent(),
              if(!isLandScape) _buildPotraitContent(deviceSize,appBar),
              if(!isLandScape)
                Container(
                    height: (deviceSize.size.height-appBar.preferredSize.height)*0.7,
                    child: TransactionList(transaction: _transaction,delete: _deleteTransaction,)),
              if(isLandScape)
              _value
                  ? Container(
                  height: (deviceSize.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                  child: Charts(recentTransaction: _recentTransaction,))
                  : Container(
                  height: (deviceSize.size.height-appBar.preferredSize.height)*0.7,
                  child: TransactionList(transaction: _transaction,delete: _deleteTransaction,))
            ]
          ),
        ),
      ),
    );
  }
}
