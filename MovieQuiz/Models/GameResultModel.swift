//
//  GameResultModel.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import UIKit

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date

    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
}
