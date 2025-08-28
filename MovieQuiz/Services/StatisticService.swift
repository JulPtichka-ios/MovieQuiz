//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import UIKit

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard

    private enum Keys {
        static let gamesCount = "gamesCount"
        static let bestGameCorrect = "bestGame.correct"
        static let bestGameTotal = "bestGame.total"
        static let bestGameDate = "bestGame.date"
        static let totalCorrectAnswers = "totalCorrectAnswers"
        static let totalQuestionsAsked = "totalQuestionsAsked"
    }

    // MARK: - Приватные промежуточные свойства

    private var totalCorrectAnswers: Int {
        get { storage.integer(forKey: Keys.totalCorrectAnswers) }
        set { storage.set(newValue, forKey: Keys.totalCorrectAnswers) }
    }

    private var totalQuestionsAsked: Int {
        get { storage.integer(forKey: Keys.totalQuestionsAsked) }
        set { storage.set(newValue, forKey: Keys.totalQuestionsAsked) }
    }

    // MARK: - Публичные свойства

    var gamesCount: Int {
        get { storage.integer(forKey: Keys.gamesCount) }
        set { storage.set(newValue, forKey: Keys.gamesCount) }
    }

    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.bestGameCorrect)
            let total = storage.integer(forKey: Keys.bestGameTotal)
            let date = storage.object(forKey: Keys.bestGameDate) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.bestGameCorrect)
            storage.set(newValue.total, forKey: Keys.bestGameTotal)
            storage.set(newValue.date, forKey: Keys.bestGameDate)
        }
    }

    var totalAccuracy: Double {
        guard totalQuestionsAsked > 0 else { return 0 }
        return Double(totalCorrectAnswers) / Double(totalQuestionsAsked) * 100
    }

    // MARK: - Сохранение результата игры

    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        totalCorrectAnswers += count
        totalQuestionsAsked += amount

        let currentGame = GameResult(correct: count, total: amount, date: Date())
        if currentGame.isBetterThan(bestGame) {
            bestGame = currentGame
        }
    }
}
