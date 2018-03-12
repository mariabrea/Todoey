//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Maria Martinez on 2/27/18.
//  Copyright © 2018 Maria Martinez Guzman. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    
    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if categories is nil return 1
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text  = categories?[indexPath.row].name ?? "No Categories added yet"
        
        //Ternary operator ==>
        //value = condition ? valueTrue : valueFalse
        
        //cell.accessoryType = item.done == true ? .checkmark : .none
        //cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    //MARK: Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = self.categories?[indexPath.row]
        }
        
    }
    
    //MARK: Data Manipulation Methods
    
    //save the context in the database
    func save(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
    }

    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            //we create a new object of type Item of the dstabase, and we fill its attributes
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            
            self.save(category : newCategory)
            
            self.tableView.reloadData()
        }
        
        //we add a textfield to the UIalert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        //we add the action to the UIalert
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }

}
