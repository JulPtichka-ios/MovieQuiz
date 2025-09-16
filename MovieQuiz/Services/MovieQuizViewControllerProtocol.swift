//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 15.09.2025.
//

import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)

    func highlightImageBorder(isCorrectAnswer: Bool)

    func showLoadingIndicator()
    func hideLoadingIndicator()

    func showNetworkError(message: String)
}
