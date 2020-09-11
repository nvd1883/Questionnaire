//
//  QuestionModel.swift
//  MultipleQuestionAnswer
//
//  Created by Aspire on 10/09/20.
//  Copyright © 2020 Nived. All rights reserved.
//

import Foundation

struct AnswerModel:Codable {
    
//    var answer:String
    var isChecked:Bool?
    var textAnswer: String?
    var radioPosition: Bool?
}

struct QuestionModel:Codable {
    var answer: [AnswerModel]?
    var questionText : String?
    var type : QuestionType?
    
}

enum QuestionType:String,Codable{
    case Check
    case Radio
    case Text
}
