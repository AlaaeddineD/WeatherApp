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
    }
    
    //Button action, pour présenter la vue météo
    @IBAction func presentWeatherView(){
        guard let weatherView = storyboard?.instantiateViewController(withIdentifier: WeatherViewController.storyboardIdentifier) as? WeatherViewController else {
            
            print("Impossible de trouver une vue avec cet identifiant \(WeatherViewController.storyboardIdentifier)")
            return
        }
        
        navigationController?.pushViewController(weatherView, animated: true)
    }
}
