//
//  ViewController.swift
//  Todoey
//
//  Created by Iwona Orocz on 05/08/2018.
//  Copyright © 2018 Iwona Orocz. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
           loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
 
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
    cell.textLabel?.text = "No Items Added" }
        
        return cell
    }
    
    
    
    //MARK - TableView Delegate Methods
    
    //how to update data using realm
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
               // realm.delete(item)
                
               item.done = !item.done
                
                }
        } catch {
            print("Error saving done status, \(error)")
        }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)}
    
    //Add new items - przycisk ktory dodaje nowe pozycje - pojawia sie popup z info
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title:"Add New Todoey Item", message: "", preferredStyle: .alert)
 
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
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
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}
 //MARK - Model
    
    
    func loadItems() {
        
       todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
}
}
    //MARK: Search bar methods

    extension TodoListViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
//            todoItems = todoItems?.filter("title CONTAINS[cd] %@",searchBar.text!).sorted(byKeyPath: "title", ascending: true)
            
            todoItems = todoItems?.filter("title CONTAINS[cd] %@",searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            
            tableView.reloadData()
    }

        //metoda do przywracania stanu listy sprzed wyszukiwania
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                loadItems()

                //usuniecie kursora i klawiatury, przywrocenie stanu poprzedniego

                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }

            }
        }
}
