//
//  AlertModelFactory.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import UIKit

final class AlertModelFactory {
    private let statisticService: StatisticServiceProtocol
    
    init(statisticService: StatisticServiceProtocol) {
        self.statisticService = statisticService
    }
    
    func makeResultAlert(
        for result: QuizResultsViewModel,
        correctAnswers: Int,
        total: Int,
        completion: @escaping () -> Void
    ) -> AlertModel {
        
        statisticService.store(correct: correctAnswers, total: total)
        
        let bestGame = statisticService.bestGame
        let totalAccuracy = String(format: "%.2f", statisticService.totalAccuracy)
        
        let message = """
        Ваш результат: \(result.text)
        Количество сыгранных игр: \(statisticService.gamesCount)
        Рекорд: \(bestGame.correct)/\(bestGame.total) (\(bestGame.date.dateTimeString))
        Средняя точность: \(totalAccuracy)%
        """
        
        return AlertModel(
            title: result.title,
            message: message,
            buttonText: result.buttonText,
            completion: completion
        )
    }
}
