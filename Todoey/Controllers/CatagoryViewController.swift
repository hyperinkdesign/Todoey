//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Jamie on 22/11/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CatagoryViewController: UITableViewController {
    
    let realm = try! Realm() //new access point to realm datababse
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // -> return
        
        return categories?.count ?? 1 // return number of rows in catagories table. nil coalecing. return at least one row if category count is nil.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // ->return
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath) //currrent indexpath its looking to populate
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"

        return cell
    }
    
    
    //MARK: - Add new catagory items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in

            let newCategory = Category() // create the context core data object
            //new core data NSmanagedObjects
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "add a new catagory"
//            textField = alertTextField // extending the scope of the alert textField
//
//            //            print(alertTextField.text)
//            //            print("now")
//        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "add a new catagory"
        }
        
        present(alert, animated: true, completion: nil)

    }
    
    
    //MARK: - TableView Delegate Methods. when you click on a table row
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods. save data and load data. CRUD
    
    func save(category: Category) { // commits the current content to the context of core data
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving catagory \(error)")
        }
        self.tableView.reloadData() // reload the text field to add the item to the array
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }

    
    //MARK: - Save items to core data
    
    
    
}
