//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import UIKit

struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: () -> Void
}
