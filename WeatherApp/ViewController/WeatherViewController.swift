//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import UIKit

protocol WeatherViewControllerProtocol {
    
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
        viewModel.delegate = self
    }
    
}

//MARK: VM Binding methods
extension WeatherViewController: WeatherViewControllerProtocol{
    
}
