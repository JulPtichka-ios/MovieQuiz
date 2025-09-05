//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 25.08.2025.
//

import Foundation
import UIKit

class QuestionFactory: QuestionFactoryProtocol {
    private let moviesLoader: MoviesLoading
    private weak var delegate: QuestionFactoryDelegate?
    
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func setup(delegate: QuestionFactoryDelegate) {
        self.delegate = delegate
    }
    
    private var movies: [MostPopularMovie] = []
    
    func loadData() {
        moviesLoader.loadMovies { [ weak self ] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    }
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self, !self.movies.isEmpty else { return }
            
            let index = Int.random(in: 0..<self.movies.count)
            let movie = self.movies[index]
            
            var imageData = Data()
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
            } catch {
                print("Failed to load image: \(error)")
            }
            
            let rating = Float(movie.rating) ?? 0
            let text = "Рейтинг этого фильма больше чем 7?"
            let correctAnswer = rating > 7
            
            let question = QuizQuestion(
                image: imageData,
                text: text,
                correctAnswer: correctAnswer
            )
            
            DispatchQueue.main.async {
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    
    func restartRound() {
        movies.shuffle()
    }
}


    //    private var questions: [QuizQuestion] = [
    //        QuizQuestion(
    //            image: "The Godfather",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: true
    //        ),
    //        QuizQuestion(
    //            image: "The Dark Knight",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: true
    //        ),
    //        QuizQuestion(
    //            image: "Kill Bill",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: true
    //        ),
    //        QuizQuestion(
    //            image: "The Avengers",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: true
    //        ),
    //        QuizQuestion(
    //            image: "Deadpool",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: true
    //        ),
    //        QuizQuestion(
    //            image: "The Green Knight",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: true
    //        ),
    //        QuizQuestion(
    //            image: "Old",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: false
    //        ),
    //        QuizQuestion(
    //            image: "The Ice Age Adventures of Buck Wild",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: false
    //        ),
    //        QuizQuestion(
    //            image: "Tesla",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: false
    //        ),
    //        QuizQuestion(
    //            image: "Vivarium",
    //            text: "Рейтинг этого фильма больше чем 6?",
    //            correctAnswer: false
    //        )
    //    ].shuffled()
    //
    //    private var currentIndex = 0
    //
    //
    //        let question = questions[currentIndex]
    //        currentIndex += 1
    //        delegate?.didReceiveNextQuestion(question: question)
    //    }
    //
