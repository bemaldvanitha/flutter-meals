import 'package:flutter/material.dart';

import '../widget/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String,bool> currentfilters;

  FilterScreen(this.saveFilters,this.currentfilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentfilters['gluten'];
    _vegetarian = widget.currentfilters['vegetarian'];
    _vegan = widget.currentfilters['vegan'];
    _lactosFree = widget.currentfilters['lactose'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed:(){
              final selectedFilter = {
                'gluten': _glutenFree,
                'lactose': _lactosFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilter);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                'Adjust Meals',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Gluten-free'),
                  value: _glutenFree,
                  subtitle: Text('only gluten free'),
                  onChanged: (newVal){
                    setState(() {
                      _glutenFree = newVal;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Vegetarian'),
                  value: _vegetarian,
                  subtitle: Text('only vegetarian'),
                  onChanged: (newVal){
                    setState(() {
                      _vegetarian = newVal;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Vegan'),
                  value: _vegan,
                  subtitle: Text('only vegan'),
                  onChanged: (newVal){
                    setState(() {
                      _vegan = newVal;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('lactos-free'),
                  value: _lactosFree,
                  subtitle: Text('only lactos free'),
                  onChanged: (newVal){
                    setState(() {
                      _lactosFree = newVal;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
