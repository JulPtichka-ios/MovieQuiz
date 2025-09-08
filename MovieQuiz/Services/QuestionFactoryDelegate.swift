//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
