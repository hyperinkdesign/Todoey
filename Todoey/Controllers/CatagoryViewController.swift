//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Jamie on 22/11/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {
    
    var catagories = [Catagory]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCatagories()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // -> return
        return catagories.count // return number of rows in catagories table
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // ->return
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath) //currrent indexpath its looking to populate
        
        cell.textLabel?.text = catagories[indexPath.row].name

        return cell
    }
    
    
    //MARK: - Add new catagory items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in

            let newCatagory = Catagory(context: self.context) // create the context core data object
            //new core data NSmanagedObjects
            newCatagory.name = textField.text!
           
            self.catagories.append(newCatagory) // add item to the item array
            
            self.saveCatagories()
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
            destinationVC.selectedCatagory = catagories[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods. save data and load data. CRUD
    
    func saveCatagories() { // commits the current content to the context of core data
        
        do {
            try context.save()
        } catch {
            print("Error saving catagory \(error)")
        }
        self.tableView.reloadData() // reload the text field to add the item to the array
    }
    
    func loadCatagories() {
        
        let request : NSFetchRequest<Catagory> = Catagory.fetchRequest() //
        
        do {
            catagories = try context.fetch(request)
        }catch{
            print("Error loading catagories \(error)")
        }
        
        self.tableView.reloadData() // reload the text field to add the item to the array
    }

    
    //MARK: - Save items to core data
    
    
    
}
