//
//  ViewController.swift
//  MultipleQuestionAnswer
//
//  Created by Aspire on 10/09/20.
//  Copyright © 2020 Nived. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let context1 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let ansModel = AnswerModel(isChecked: false)
    let ansModel1 = AnswerModel(isChecked: false)
    let ansModel2 = AnswerModel(isChecked: false)
    let ansModel3 = AnswerModel(isChecked: false)
    
    var checkBoxObject = QuestionModel()
    var radioObject = QuestionModel()
    var textObject = QuestionModel()
    var questionArray = [QuestionModel]()
    var picker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCheckBoxCell()
        registerRadioButtonCell()
        registerTextBoxCell()
        hideKeyboardWhenTappedAround()
        loadData()
     
        
    }
    @IBAction func addAction(_ sender: Any) {
        showSheet()
    }
    
    func registerCheckBoxCell(){
        let nibCell = UINib(nibName: "CheckBoxTableCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "checkMarkCell")
    }
    
    func registerRadioButtonCell(){
        let nibCell = UINib(nibName: "RadioButtonTableCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "radioButtonTableCell")
    }
    
    func registerTextBoxCell(){
        let nibCell = UINib(nibName: "TextBoxTableCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "textBoxCell")
    }
    
    

    
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        saveData()
    }
    
    
    
    func saveData(isDelete: Bool = false){
        
        let array = questionArray
        if let data = try? PropertyListEncoder().encode(array) {
            UserDefaults.standard.set(data, forKey: "SavedItemArray")
            showPopUp(isDelete: isDelete)
        }else{
            print("ERROR SAVING")
        }
    }
    
    func showPopUp(isDelete: Bool){
        var msg = ""
        if isDelete{
            msg = "Item deleted successfully"
        } else{
            msg = "Answers saved successfully"
        }
        let refreshAlert = UIAlertController(title: "Questionnaire", message: msg, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    func loadData(){
        
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "SavedItemArray") {
            let array = try! PropertyListDecoder().decode([QuestionModel].self, from: data)
            questionArray = array
            tableView.reloadData()
            
            
        }
            
        //MARK: - called in case there are no items
        else{
            checkBoxObject = QuestionModel(answer: getCheckAnswerArray(), type:QuestionType.Check)
            radioObject = QuestionModel(answer: getCheckAnswerArray(), type: QuestionType.Radio)
            textObject = QuestionModel(answer: getCheckAnswerArray(), type: QuestionType.Text)
            
            questionArray.append(checkBoxObject)
            questionArray.append(radioObject)
            questionArray.append(textObject)
        }
        
        
    }
    
    //Action sheet function
    func showSheet(){
        let alert = UIAlertController(title: "Question Type", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Check", style: .default , handler:{ (UIAlertAction)in
            self.addAction(.Check)
        }))
        
        alert.addAction(UIAlertAction(title: "Radio", style: .default , handler:{ (UIAlertAction)in
            self.addAction(.Radio)
        }))
        
        alert.addAction(UIAlertAction(title: "Text", style: .default , handler:{ (UIAlertAction)in
            self.addAction(.Text)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in
               }))
               
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    
    
    
    
    func getCheckAnswerArray() -> [AnswerModel] {
        var answerArray = [AnswerModel]()
        answerArray.append(ansModel)
        answerArray.append(ansModel2)
        answerArray.append(ansModel3)
        answerArray.append(ansModel1)
        return answerArray
    }
    
    
    
    
}

//MARK: - Tableview delegate functions

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell
        let type = questionArray[indexPath.row].type
        switch type {
        case .Check:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkMarkCell") as! CheckBoxTableCell
            cell.setData(answer: questionArray[indexPath.row].answer!,index: indexPath)
            cell.checkboxDelegateHandler = self
            return cell
            
        case .Radio:
            let cell = tableView.dequeueReusableCell(withIdentifier: "radioButtonTableCell") as! RadioButtonTableCell
            cell.setData(answer: questionArray[indexPath.row].answer!,index: indexPath)
            
            cell.rButtonDelegate = self
            return cell
            
            
        case .Text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textBoxCell") as! TextBoxTableCell
            cell.setData(answer: questionArray[indexPath.row].answer!, index: indexPath)
            cell.textFieldDelegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = questionArray[indexPath.row].type
        switch type  {
        case .Text:
            return 130.0
       
        default:
            return 250.0
        }
    }
    
    func addAction(_ type: QuestionType){
        switch type {
        case .Check:
            checkBoxObject = QuestionModel(answer: getCheckAnswerArray() , type:QuestionType.Check)
            questionArray.append(checkBoxObject)
            self.tableView.reloadData()
            return
        case .Radio:
            radioObject = QuestionModel(answer: getCheckAnswerArray(), type: QuestionType.Radio)
            questionArray.append(radioObject)
            self.tableView.reloadData()
            return
        case .Text:
            textObject = QuestionModel(answer: getCheckAnswerArray(), type: QuestionType.Text)
            questionArray.append(textObject)
            self.tableView.reloadData()
            return
       
        }

    }
    
    func deleteFunction(_ index: IndexPath){
        questionArray.remove(at: index.row)
        saveData(isDelete: true)
        self.tableView.reloadData()
    }
    
    
}

extension ViewController: checkBoxDelegate {
    func deleteClicked(index: IndexPath) {
        deleteFunction(index)
        
    }
    
    func checkBoxClicked(_ buttonTag: Int, _ senderSelected: Bool, index: IndexPath) {
        if let buttonPos = getPositionFromTag(buttonTag: buttonTag){
            guard let isChecked = questionArray[index.row].answer?[buttonPos].isChecked else { return}
            //            let st = AnswerModel(isChecked: !isChecked)
            questionArray[index.row].answer?[buttonPos].isChecked = !isChecked
            
        }
        
    }
    
    
    func getPositionFromTag(buttonTag: Int) -> Int?{
        switch buttonTag {
        case 101,201:
            return 0
        case 102,202:
            return 1
        case 103,203:
            return 2
        case 104,204:
            return 3
        default: return 0
            
        }
    }
    
    
    
}


extension ViewController: radioButtonDelegate {
    func deleteRadioClicked(index: IndexPath) {
        deleteFunction(index)
    }
    
    func radioButtonClicked(tag: Int, index: IndexPath) {
        if let buttonPos = getPositionFromTag(buttonTag: tag){
            
            guard let isChecked = questionArray[index.row].answer?[buttonPos].isChecked else { return}
            //                   let st = AnswerModel(isChecked: !isChecked)
            //                    questionArray[index.row].answer?.insert(st, at: buttonPos)
            for i in 0...3{
                if buttonPos != i {
                    questionArray[index.row].answer?[i].isChecked = false
                }
                else{
                    questionArray[index.row].answer?[i].isChecked = true
                }
                
            }
        }
    }
    
    
    
}

extension ViewController: textFieldChanged {
    func textValueChanged(text: String, index: IndexPath) {
        questionArray[index.row].answer![0].textAnswer = text
    }
    
    
    
    
}

extension UIViewController {
    
    //MARK: - function to hide keyboard when tapped around
    
    func hideKeyboardWhenTappedAround(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        
        view.endEditing(true)
    }
    
}



