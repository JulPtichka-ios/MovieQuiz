//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import Foundation

protocol QuestionFactoryProtocol {
    func requestNextQuestion()
    func setup(delegate: QuestionFactoryDelegate)
    func loadData()
}
