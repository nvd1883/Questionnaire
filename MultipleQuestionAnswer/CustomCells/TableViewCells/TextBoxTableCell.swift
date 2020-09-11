//
//  TextBoxTableCell.swift
//  MultipleQuestionAnswer
//
//  Created by Aspire on 10/09/20.
//  Copyright © 2020 Nived. All rights reserved.
//

import UIKit
protocol textFieldChanged {
    func textValueChanged(text: String,index: IndexPath)
    func deleteClicked(index:IndexPath)
}

class TextBoxTableCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UITextField!
       var indexPath = IndexPath()
    var textFieldDelegate : textFieldChanged?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.addTarget(self, action: #selector(TextBoxTableCell.textFieldDidChange(_:)), for: .editingChanged)
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
    
    @objc  func textFieldDidChange(_ textField: UITextField) {
        self.textFieldDelegate?.textValueChanged(text: textField.text ?? "", index: indexPath)
    
}
    
    @IBAction func deleteClicked(_ sender: Any) {
        self.textFieldDelegate?.deleteClicked(index: indexPath)
    }
    
}
