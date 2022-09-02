//
//  TableViewCell.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import Foundation

protocol TableViewCell {
    associatedtype CellViewModel
    
    func addViews()
    func setupConstraints()
    func configCell(with item: CellViewModel)
}
