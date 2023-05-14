//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import Foundation

class WeatherViewModel{
    
    var delegate: WeatherViewControllerProtocol?
    
    //Texts properties
    private let texts = ["Nous téléchargeons les données…",
                         "C’est presque fini…",
                         "Plus que quelques secondes avant d’avoir le résultat…"]
    private let textChangeInterval: Int = 6 //In seconds
    private var currentTextIndex: Int = -1
    
    //Timer properties
    private let progressBarFillTime: Float = 60 //In second
    private var progressValueEachSecond: Float = 0 //In seconds
    private var secondsCounter: Int = 0
    
    init() {
        progressValueEachSecond = 1/progressBarFillTime
    }
    
    //Configuration et démarrage de la minuterie
    func setupAndStartTimer(){
        
        //Afficher le premier text
        delegate?.updateTextLabelValue(text: getNextTextToShow())
        
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    //exécuté par le Timer à chaque intervalle de temps
    @objc func fireTimer(timer: Timer){
        secondsCounter += 1
        
        guard let delegate = delegate else {
            print("No delegate found. Timer canceled")
            timer.invalidate()
            return
        }
        
        //Incrémenter la barre de progression et arrêt du Timer si la barre est pleine
        if delegate.updateProgressBarProgress(progress: progressValueEachSecond){
            print("Done counting")
            timer.invalidate()
        }
        
        //Mettre à jour le texte toutes les 6 secondes
        if (secondsCounter % textChangeInterval == 0){
            delegate.updateTextLabelValue(text: getNextTextToShow())
        }
    }
    
    //Gere la boucle sur le array de textes et renvoyer le bon texte
    private func getNextTextToShow() -> String {
        currentTextIndex += 1
        if currentTextIndex >= texts.count{
            currentTextIndex = 0
        }
        return texts[currentTextIndex]
    }
}
