//
//  CheckBoxTableCell.swift
//  MultipleQuestionAnswer
//
//  Created by Aspire on 10/09/20.
//  Copyright © 2020 Nived. All rights reserved.
//

import UIKit

protocol checkBoxDelegate {
    func checkBoxClicked(_ buttonTag: Int, _ senderSelected: Bool,index: IndexPath)
    }


class CheckBoxTableCell: UITableViewCell {
    
    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var cb1: UIButton!
    @IBOutlet weak var cb2: UIButton!
    @IBOutlet weak var cb3: UIButton!
    @IBOutlet weak var cb4: UIButton!
    var checkboxDelegateHandler: checkBoxDelegate?
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func cb1Clicked(_ sender: UIButton) {
        self.checkboxDelegateHandler?.checkBoxClicked(sender.tag,sender.isSelected,index: self.indexPath)
        sender.isSelected = !sender.isSelected
        print(sender.isSelected)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(answer: [AnswerModel],index: IndexPath) {
        self.cb1.isSelected = answer[0].isChecked!
        self.cb2.isSelected = answer[1].isChecked!
        self.cb3.isSelected = answer[2].isChecked!
        self.cb4.isSelected = answer[3].isChecked!
        self.indexPath = index
    }
    
}
