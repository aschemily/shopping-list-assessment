//
//  ItemTableViewCell.swift
//  Shopping List Assessment
//
//  Created by Emily Asch on 2/11/22.
//

import UIKit

//Protocol/Delegate

//declare protocol
protocol ItemCompletionDelegate: AnyObject{
    func itemCellButtonTapped(for cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var completeBtn: UIButton!
    
    //step 2 create delegate
    weak var delegate: ItemCompletionDelegate?
    
    
    var item: Item?{
        didSet{
            updateViews()
        }
    }
    
    func updateViews(){
        print("inside update views")
        guard let item = item else {return}
        itemNameLabel.text = item.name
        
        if item.isComplete == true{
            completeBtn.setBackgroundImage(UIImage(named: "complete"), for: UIControl.State.normal)
        }else{
            completeBtn.setBackgroundImage(UIImage(named: "in complete"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func checkBoxBtnPressed(_ sender: Any) {
        delegate?.itemCellButtonTapped(for: self)
    }
    

}
