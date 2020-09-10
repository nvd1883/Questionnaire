//
//  TextBoxTableCell.swift
//  MultipleQuestionAnswer
//
//  Created by Aspire on 10/09/20.
//  Copyright © 2020 Nived. All rights reserved.
//

import UIKit

class TextBoxTableCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UITextField!
       var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(answer:[AnswerModel],index:IndexPath) {
        self.indexPath = index
        self.nameTextField.text = answer[0].textAnswer
    }
    
}
