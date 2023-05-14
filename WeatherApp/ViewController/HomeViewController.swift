//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()
    }
    
    private func checkInternetAvailability() -> Bool {
        if NetworkMonitor.shared.isInternetAvailable(){
            return true
        }
        
        // Afficher une alerte
        self.displayAlert(title: "Attention", message: "une connexion Internet est requise ! veuillez vérifier votre connexion et réessayer", actionButtonText: "Ok", style: .alert, vc: self)
        
        return false
    }
    
    //Button action, pour présenter la vue météo
    @IBAction func presentWeatherView(){
        
        //Empêcher l'utilisateur d'ouvrir la vue météo sans Internet
        if !checkInternetAvailability(){
            return
        }
        
        guard let weatherView = storyboard?.instantiateViewController(withIdentifier: WeatherViewController.storyboardIdentifier) as? WeatherViewController else {
            
            print("Impossible de trouver une vue avec cet identifiant \(WeatherViewController.storyboardIdentifier)")
            return
        }
        
        NetworkMonitor.shared.stopMonitoring()
        navigationController?.pushViewController(weatherView, animated: true)
    }
}
