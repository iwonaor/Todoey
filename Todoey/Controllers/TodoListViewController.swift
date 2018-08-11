//
//  ViewController.swift
//  Todoey
//
//  Created by Iwona Orocz on 05/08/2018.
//  Copyright © 2018 Iwona Orocz. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item] ()
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(dataFilePath)
        
        loadItems()
        
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
         // itemArray = items}
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        //Ternary operator
        //value = condition ? valueifTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //if item.done == true {
         //   cell.accessoryType = .checkmark }
       // else {
            
          //  cell.accessoryType = .none
        //}
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        //if itemArray[indexPath.row].done == false {
          //  itemArray[indexPath.row].done = true }
        //else {
          //  itemArray[indexPath.row].done = false}
       //tableView.reloadData()
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)}
    
    //Add new items - przycisk ktory dodaje nowe pozycje - pojawia sie popup z info
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title:"Add New Todoey Item", message: "", preferredStyle: .alert)
 
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
    
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}
 
        func saveItems() {
    let encoder = PropertyListEncoder()
    do {
    let data = try encoder.encode(itemArray)
    try data.write(to: dataFilePath!)
    } catch { print("Error encoding item array, \(error)")
    
    }
        self.tableView.reloadData() //sposob na to zeby dodawaly sie nowe pozycje do tabelki
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Errors")
            }
    }
}
}
