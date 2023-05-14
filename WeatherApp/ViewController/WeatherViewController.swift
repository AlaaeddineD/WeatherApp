//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import UIKit

protocol WeatherViewControllerProtocol {
    func updateProgressBarProgress(progress: Float) -> Bool
    func updateTextLabelValue(text: String)
}

class WeatherViewController: UIViewController {
    
    static let storyboardIdentifier = "WeatherView"
    
    //UI
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
        viewModel.delegate = self
        viewModel.setupAndStartTimer()
    }
}

//MARK: VM Binding methods
extension WeatherViewController: WeatherViewControllerProtocol{
    
    //Mettre à jour la valeur de progression de la barre de progression
    //Return si la barre de progression est remplie ou non
    func updateProgressBarProgress(progress: Float) -> Bool{
        progressBar.progress += progress
        return progressBar.progress == 1
    }
    
    func updateTextLabelValue(text: String) {
        textLabel.text = text
    }
}
