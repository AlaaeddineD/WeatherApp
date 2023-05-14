//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import Foundation

class WeatherViewModel{
    
    var delegate: WeatherViewControllerProtocol?
    private let weatherApiCall = WeatherApiCall()
    
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
    
    //Cities properties
    private var cities: [City] = [
    City(name: "Rennes", latitude: 48.1113387, longitude: -1.6800198),
    City(name: "Paris", latitude: 48.8588897, longitude: 2.320041),
    City(name: "Nantes", latitude: 47.2186371, longitude: -1.5541362),
    City(name: "Bordeaux", latitude: 44.841225, longitude: -0.5800364),
    City(name: "Lyon", latitude: 45.7578137, longitude: 4.8320114),
    ]
    private var currentCityIndex: Int = -1
    
    
    init() {
        progressValueEachSecond = 1/progressBarFillTime
    }
    
    //Configuration et démarrage de la minuterie
    func setupAndStartTimer(){
        
        //Afficher le premier text
        delegate?.updateTextLabelValue(text: getNextTextToShow())
        
        //Faire l'appel API pour la première ville
        makeApiCallForCurrentCity()
        
        //Lance le Timer
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
        
        if (secondsCounter % 10 == 0){
            makeApiCallForCurrentCity()
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
    
    //Gere la boucle sur les villes et fait l'appel Api pour la bonne ville
    private func makeApiCallForCurrentCity(){
        currentCityIndex += 1
        
        if currentCityIndex >= cities.count{
            return
        }
        loadWeatherData(city: cities[currentCityIndex])
    }
    
    //Make the async API Call
    private func loadWeatherData(city: City){
        print("Making api call for \(city.name) at \(secondsCounter)")
        Task{
            let _ = await weatherApiCall.makeWeatherApiCall(city: city)
        }
    }
}
