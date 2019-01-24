//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Alex on 23/01/2019.
//  Copyright © 2019 Advanced Tech. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCatergory()
    
    }
 
    //Mark - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem){
        print("button pressed")
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            //////MARK - get persistant container from app delegate
            print("button second action")
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
    }
    
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            }
    
            alert.addAction(action)
    
            present(alert, animated:true, completion: nil)
        
    }
   


    
    
    
    
    
    
    //MARK: - TableView Datasource Methods
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
   
    
    
    
    //MARK: - TableView Data Manipulation Methods
    func saveCategory(){
        
        do {
            try context.save()
        } catch {
            print("Error saving data \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    
    func loadCatergory(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error loading form context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
}
