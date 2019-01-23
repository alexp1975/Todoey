//
//  ViewController.swift
//  Todoey
//
//  Created by Alex on 22/01/2019.
//  Copyright © 2019 Advanced Tech. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

   
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in:
//            .userDomainMask))
        
        loadItems()
        
    }
    
    
    //MARK  - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
            cell.textLabel?.text = item.title
        //Ternary
            cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //     to delete from DB
  //     1 context.delete(itemArray[indexPath.row])
  //     2 itemArray.remove(at: indexPath.row)
  //     3 saveItems
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)

}

//Mark - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           

 //////MARK - get persistant container from app delegate
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated:true, completion: nil)
        
        }
    
    //Mark - Model Manipulation Methods
    func saveItems(){
    
    do {
       try context.save()
    } catch {
        print("Error saving data \(error)")
    }
    
    self.tableView.reloadData()
    }
    
    
    
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){

  //      let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error loading form context \(error)")
        }
        self.tableView.reloadData()
}

    
}

//MARK - SearchBar Methods
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        print(request)
        loadItems(with: request)
        

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }


        }
    }
    
}
