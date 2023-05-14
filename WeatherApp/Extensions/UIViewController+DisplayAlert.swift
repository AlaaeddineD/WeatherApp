//
//  UIViewController+DisplayAlert.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import Foundation
import UIKit

extension UIViewController{
    
    func displayAlert(title: String, message: String, actionButtonText: String, style: UIAlertController.Style, vc: UIViewController, handler: ((UIAlertAction) -> Void)? = nil){
        
        let dialogAlert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let alertAction = UIAlertAction(title: actionButtonText, style: .cancel, handler: handler)
        dialogAlert.addAction(alertAction)
        
        vc.present(dialogAlert, animated: true)
    }
}
