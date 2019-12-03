import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    print('glutenfree now: $_glutenFree');
    print('lactosefree now: $_lactoseFree');
    print('vegan now: $_vegan');
    print('vegetarian now: $_vegetarian');
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    'Gluten-free',
                    ('Only include gluten-free meals.'),
                    _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                    print('value gluten: $_glutenFree');
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-free',
                    ('Only include lactose-free meals.'),
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                    print('value lactose: $_lactoseFree');
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian',
                    ('Only include vegetarian meals.'),
                    _vegetarian, (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                    print('value vegetarian: $_vegetarian');
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', ('Only include vegan meals.'), _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                    print('value vegan: $_vegan');
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
