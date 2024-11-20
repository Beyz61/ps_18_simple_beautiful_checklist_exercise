import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository{
final  SharedPreferencesAsync prefs = SharedPreferencesAsync();

 List<String> _items = [];

  //  hinzufügen und speichern
  @override
  Future<void> addItem(String item) async  {   
    _items.add(item);
    await _saveItem(); // Speichert Liste in SharedPreferences
  }
// löschen und das gelöschte speichern 
  @override
  Future<void> deleteItem(int index) async {
    _items.removeAt(index);
    await _saveItem();

  }
// bearbeiten und das bearbeitete speichern 
  @override
  Future<void> editItem(int index, String newItem) async {
  getItems();
  _items[index] = newItem;
      await _saveItem();
  }

// zeigt alles was bereits gespeichert wurde in einer liste
  @override
  Future<List<String>> getItems() async { 
    _items = await prefs.getStringList("tasks") ?? [];
    return _items;
  }

// Zeigt unter Statistik an wie viele Einträge gespeichert wurden.
  @override 
  Future<int> get itemCount async {
   await getItems();
   return _items.length;
     }

    // Speichert die Funktion saveItem
 Future<void> _saveItem() async{
 await prefs.setStringList("tasks", _items);
 }


}


