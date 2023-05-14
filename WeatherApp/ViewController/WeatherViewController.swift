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
    func showCitiesTableView(cities: [City])
}

class WeatherViewController: UIViewController {
    
    static let storyboardIdentifier = "WeatherView"
    
    //UI
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    private let viewModel = WeatherViewModel()
    private var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
        setupTableView()
        viewModel.delegate = self
        viewModel.setupAndStartTimer()
    }
}

//MARK: ViewMmodel Binding methods
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
    
    func showCitiesTableView(cities: [City]) {
        self.cities = cities
        weatherTableView.reloadData()
    }
}

//MARK: Table view
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    private func setupTableView(){
        let nib = UINib(nibName: "CityWeatherTableViewCell", bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: CityWeatherTableViewCell.cellIdentifier)
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = weatherTableView.dequeueReusableCell(withIdentifier: CityWeatherTableViewCell.cellIdentifier, for: indexPath) as? CityWeatherTableViewCell {
            
            cell.setCellData(city: cities[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
