//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import UIKit

protocol StatisticServiceProtocol {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameResult { get }

    func store(correct count: Int, total amount: Int)
}
