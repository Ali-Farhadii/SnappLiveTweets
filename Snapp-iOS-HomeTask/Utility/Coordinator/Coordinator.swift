//
//  Coordinator.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
