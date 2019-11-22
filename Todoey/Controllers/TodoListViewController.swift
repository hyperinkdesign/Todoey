//
//  ViewController.swift
//  Todoey
//
//  Created by Jamie on 23/08/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import UIKit
import CoreData


//CRUD: Creating Reading Updating Destroying using the context then comit to persisent data

class TodoListViewController: UITableViewController {

    //let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"] // imutable array
    //var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]   // mutable array

    var itemArray = [Item]()
    
           // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") // load the document directory
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // loads the Item .plist
        loadItems() // initially load save items from core data
        
        //print(dataFilePath) // find the save path for the menu items inside the container app
        

//        let newItem1 = Item() //an array of custom items 
//        newItem1.title = "Find Mike"
//        //newItem1.done = true
//        itemArray.append(newItem1)
//        
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        
        // use user defaults to pull out an array
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }
    
    //MARK - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // -> return
        return itemArray.count // create 3 rows in the table view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // ->return

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //currrent indexpath its looking to populate
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Ternary Operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
       // print(indexPath.row)
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title") // a method to update the NSMangedObject
        
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done // use the or operator to reverse the statment
        
//        context.delete(itemArray[indexPath.row]) // remove the data from the permenent store
//        itemArray.remove(at: indexPath.row) //remove the current item from the item array
        
        saveItems() //call this method when the table data has changed
        
        tableView.reloadData() // force the table view to call the methods again and reload data
        
        // method - check row at index path
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // if it dosnt have a mark but needs one
//        }
        
        tableView.deselectRow(at: indexPath, animated: true) // animate the row selection to flash 1 sec grey
    }
    
    
    //MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) { // add the bar button item
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user clicks the add item button
            //print("success!")
            //print(textField.text)
            
            let newItem = Item(context: self.context) // create the context core data object
            //new core data NSmanagedObjects
            newItem.title = textField.text!
            newItem.done = false // sets new items to 'not done' see the core data entities
            self.itemArray.append(newItem) // add item to the item array
            
         self.saveItems() //call this method when the table data has changed
            
            //self.itemArray.append(textField.text!) // add item fro mthe text field
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray") // two things needed to save user defaults. A value such as an array or string etc data type and the key to retrive the item and grab it back

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
    
    // MARK - Model Manipulation Methods
    
    func saveItems() { // commits the current content to the context of core data
        
        //let encoder = PropertyListEncoder() // a new object
        
        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
            
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        // encode the item array into a p.list
        
        self.tableView.reloadData() // reload the text field to add the item to the array
    }
  
    
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
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
       // let request : NSFetchRequest<Item> = Item.fetchRequest()
        // have to speak to the context before we can accesss the core data
        do {
        itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    

}

    // MARK - Search bar methods. IMPORTIANT! move multiple delegate protocol methods outside of the main class using extensions

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        // query to specify what we want to get back from the DB. NSPredicate is an NSFoundartion class from Objective-C
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) // [cd] case and diacritic sensitive. look for the tables which contain the text. modifiers and logical conditions CONTAINS %@ etc. check the realm website cheetsheet pdf. String comparison operators. Check out NSPredicate
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
        
        //tableView.reloadData()
        
        //print(searchBar.text!)
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

