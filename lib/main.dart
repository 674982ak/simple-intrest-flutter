import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "New Apps",
      home: SIForm(),
      theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent
      ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {

  var _currencies = ["Rupee", "Doller", "Pound", "Others"];
  var _currentSelectItems = "Rupee";

  TextEditingController principleControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termsControlled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(title: Text("Calculater"),),
      body: Container(
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 24.0, left: 24.0, right: 24.0),
              child: TextField(
                style: textStyle,
                keyboardType: TextInputType.number,
                controller: principleControlled,
                decoration: InputDecoration(
                    labelText: "Pricipal",
                    hintText: "Enter Pricipal eg 12000",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.0, left: 24.0 , right: 24.0),
              child: TextField(
                style: textStyle,
                keyboardType: TextInputType.number,
                controller: roiControlled,
                decoration: InputDecoration(
                    labelText: "Rate of Intrest",
                    hintText: "In Percents",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ) ,
            ),
            Padding(
             padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child:  Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: termsControlled,
                      decoration: InputDecoration(
                          labelText: "Terms",
                          hintText: "how many year",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ) ,
                  ),
                 Container(
                   width: 12.0,
                 ),

                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem){
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected){
                        _onDropDownItemSelect(newValueSelected);
                      },
                      value: _currentSelectItems,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text("calulate", textScaleFactor: 1.5,),
                        onPressed: (){
                          setState(() {
                          this.displayResult = _calculateTotalReturns();
                          });

                        },
                      )
                  ),
                  Expanded(
                      child: RaisedButton(
                       color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).accentColor,
                        child: Text("Submit", textScaleFactor: 1.5,),
                        onPressed: (){
                          setState(() {
                            _reset();
                          });
                        },
                      )
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
              child: Text(this.displayResult),
            )
          ],
        ),
      ),
    );
  }

  void _onDropDownItemSelect(String newValueSelected){
    setState(() {
      this._currentSelectItems = newValueSelected;
    });
  }

  Widget getImageAsset(){

    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage,
      width: 150.0,
      height: 150.0,
    );
    return Container(child: image,
      alignment: Alignment.center,
//      padding: EdgeInsets.only(top: 32.0, left: 100.0, ),
    );
  }

  String _calculateTotalReturns(){

      double principle = double.parse(principleControlled.text);
      double roi = double.parse(roiControlled.text);
      double terms = double.parse(termsControlled.text);

      double totalAmountPayable = principle + (principle * roi * terms) / 100;

      String result = 'after $terms year , your investment worth $totalAmountPayable $_currentSelectItems';

      return result;
  }

  void _reset(){
    principleControlled.text = '';
    roiControlled.text ='';
    termsControlled.text = '';
    displayResult = '';
    _currentSelectItems = _currencies[0];


  }

}
