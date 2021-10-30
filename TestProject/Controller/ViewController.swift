//
//  ViewController.swift
//  TestProject
//
//  Created by iMac on 27/10/21.
//

import UIKit

class ViewController: UIViewController {

    var listArray                       : MODEL_ACROMINES? // List of Models
    var dataViewModel                   = DataViewModel()
    var cellId                          = "customTableViewCell"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textFieldToSearch: UITextField!
    @IBOutlet weak var tableView        : UITableView?{
        didSet{
            tableView?.tableFooterView = UIView()
        }
    }
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialise View model Data
        initViewModel()
        
        // Observe Text Change Value
        textFieldToSearch.addTarget(
            nil,
            action: #selector(textChanged),
            for: UIControl.Event.editingChanged
        )
    }
    
    //MARK:- Init View Model
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView!.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
            }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
        dataViewModel.getData(keyword: "")//Pass Default Val
    }

}

//MARK:-TableView
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    // TOTAL NUMBER OF CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    //SET CELL DATA
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.configCellData(model: dataViewModel.getCellViewModel( at: indexPath ))
        return cell
    }
    
    //CUSTOM HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
}
extension ViewController: UITextFieldDelegate {
    
    //MARK:- Text changed
    @objc func textChanged()
    {
        if let text = textFieldToSearch.text,text.count>0{
            dataViewModel.getData(keyword: text)
        }
    }
    
}
