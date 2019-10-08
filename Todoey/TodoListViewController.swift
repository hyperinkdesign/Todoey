//
//  ViewController.swift
//  Todoey
//
//  Created by Jamie on 23/08/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"] // imutable array
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]   //mutable array
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // -> return
        return itemArray.count // create 3 rows in the table view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // ->return
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //currrent indexpath its looking to populate
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
       // print(indexPath.row)
        
        // method - check row at index path
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // if it dosnt have a mark but needs one
        }
        
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
            self.itemArray.append(textField.text!) // add item fro mthe text field
            
            self.tableView.reloadData() // reload the text field to add the item to the array
            
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
}

