//
//  CustomTableViewCell.swift
//  TestProject
//
//  Created by iMac on 27/10/21.
//


import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    func configCellData(model:DataListCellViewModel){
        lblTitle.text = " " + model.titleText
        if let modeData = model.subTitleList{
            lblSubTitle.text = "- " + (modeData.map({$0.lf!})).joined(separator: "\n- ")

        }

    }
}
