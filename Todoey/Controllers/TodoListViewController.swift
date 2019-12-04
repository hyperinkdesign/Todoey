//
//  ViewController.swift
//  Todoey
//
//  Created by Jamie on 23/08/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import UIKit
import RealmSwift

//CRUD: Creating Reading Updating Destroying using the context then comit to persisent data

class TodoListViewController: UITableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{ //fires as soon as selectedCatagory is used ie a cell is clicked
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    //MARK: - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // -> return
        return todoItems?.count ?? 1 // create 3 rows in the table view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // ->return

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //currrent indexpath its looking to populate
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write { // updates the database
                    //realm.delete(item) // click row to delete item
                    item.done = !item.done // false become true, true becomes false
                }
            } catch {
                print("Error saving done staus, \(error)")
            }
        }
        
        tableView.reloadData()
        
//        todoItems?[indexPath.row].done = !(todoItems?[indexPath.row].done ?? 1)
//
//        saveItems() //call this method when the table data has changed

        tableView.deselectRow(at: indexPath, animated: true) // animate the row selection to flash 1 sec grey
    }

    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) { // add the bar button item
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in

            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField // extending the scope of the alert textField
            
//            print(alertTextField.text)
//            print("now")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Model Manipulation Methods
    

  
    // load items from the core data model when apps terminated using persistant data
//    func loadItems() {
//
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }
//    }
    
  //  loads the items from the items array
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
}

// MARK: - Search bar methods. IMPORTIANT! move multiple delegate protocol methods outside of the main class using extensions

extension TodoListViewController: UISearchBarDelegate {// extends base view contoller outside of the main controller. modualise and split functionality. method triggered when used presses the search bar field

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
 //       todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true) // take a list of items and filter using a predicate the same as core data. also filter items based on the search criteria. check out realm.io NSPredicate cheetsheet for more filters.
        
               todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems() // re-fetches all the items again from the persistant store method

            DispatchQueue.main.async { // run this method on the main queue
                searchBar.resignFirstResponder() //no longer be the item selected
            }
        }
    }


}
