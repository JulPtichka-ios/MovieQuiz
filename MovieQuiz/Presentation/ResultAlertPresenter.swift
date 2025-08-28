//
//  ResultAlertPresenter..swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 27.08.2025.
//


import UIKit

final class ResultAlertPresenter {
    private let alertPresenter: AlertPresenter
    private let alertModelFactory: AlertModelFactory
    private weak var viewController: UIViewController?

    init(viewController: UIViewController, statisticService: StatisticServiceProtocol) {
        self.viewController = viewController
        self.alertPresenter = AlertPresenter()
        self.alertModelFactory = AlertModelFactory(statisticService: statisticService)
    }

    func showResults(
        result: QuizResultsViewModel,
        correctAnswers: Int,
        totalQuestions: Int,
        onCompletion: @escaping () -> Void
    ) {
        let alertModel = alertModelFactory.makeResultAlert(
            for: result,
            correctAnswers: correctAnswers,
            total: totalQuestions,
            completion: onCompletion
        )

        if let vc = viewController {
            alertPresenter.show(in: vc, model: alertModel)
        }
    }
}
