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
        
        // Create an alert
        var dialogMessage = UIAlertController(title: "Attention", message: "une connexion Internet est requise ! veuillez vérifier votre connexion et réessayer", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
        
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
        
        navigationController?.pushViewController(weatherView, animated: true)
    }
}
