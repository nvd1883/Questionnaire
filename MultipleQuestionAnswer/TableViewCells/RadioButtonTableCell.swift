//
//  RadioButtonTableCell.swift
//  MultipleQuestionAnswer
//
//  Created by Aspire on 10/09/20.
//  Copyright © 2020 Nived. All rights reserved.
//

import UIKit

class RadioButtonTableCell: UITableViewCell {
    
    @IBOutlet weak var rb1: UIButton!
    @IBOutlet weak var rb2: UIButton!
    @IBOutlet weak var rb3: UIButton!
    
    @IBOutlet weak var rb4: UIButton!
    var indexPath = IndexPath()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    @IBAction func rb1Clicked(_ sender: UIButton) {
        deselecRadiobutons(selectedTag: sender)
        
    }
    func deselecRadiobutons(selectedTag:UIButton){
        for i in 201 ... 204 {
            if selectedTag.tag == i {
                if let button = self.viewWithTag(selectedTag.tag) as? UIButton
                {
                    button.isSelected = true
                    
                }
                
            }
            else {
                if let button = self.viewWithTag(i) as? UIButton
                {
                    button.isSelected = false
                    
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(answer: [AnswerModel],index: IndexPath) {
         self.rb1.isSelected = answer[0].isChecked!
         self.rb2.isSelected = answer[1].isChecked!
         self.rb3.isSelected = answer[2].isChecked!
         self.rb4.isSelected = answer[3].isChecked!
         self.indexPath = index
     }
    
}
