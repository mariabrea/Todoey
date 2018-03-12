//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Maria Martinez on 2/27/18.
//  Copyright © 2018 Maria Martinez Guzman. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    
    var categoryArray = [Category]()
    
    //we create the context to interact with the database. to do this we grab the persistent container of appdelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    
    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
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
            destinationVC.selectedCategory = self.categoryArray[indexPath.row]
        }
        
    }
    
    //MARK: Data Manipulation Methods
    
    //save the context in the database
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
    }

    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {//the = means if provide no argument then the argument is Item.fetchRequest()
        //we make a request to fetch data from the database
        //we have to specify the type of the data and the Entity of the database
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            //we create a new object of type Item of the dstabase, and we fill its attributes
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            //what will happen once the user clickes the add button in UIalert
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
            
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
