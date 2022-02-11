//
//  ShoppingListTableViewController.swift
//  Shopping List Assessment
//
//  Created by Emily Asch on 2/11/22.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {


    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: Helper function
   
    
    @IBAction func createNewItemPressed(_ sender: Any) {
        let ac = UIAlertController(title: "add new item", message: "enter name", preferredStyle: .alert)
     
        ac.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "item name..."
            
        })
        
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: {(action) in
          //  print("save pressed")
            guard let itemText = ac.textFields?[0].text, !itemText.isEmpty else {return}
            ItemController.shared.createItem(name: itemText)
            self.tableView.reloadData()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
        present(ac, animated: true, completion: nil)
    }
    

 

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell()}
        
        let item = ItemController.shared.items[indexPath.row]
        cell.item = item
        cell.delegate = self
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.deleteItem(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
}// end of class

extension ShoppingListTableViewController: ItemCompletionDelegate{
    func itemCellButtonTapped(for cell: ItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let item = ItemController.shared.items[indexPath.row]
        
        ItemController.shared.togglePressed(item: item)
        cell.updateViews()
    }
    
    
}
