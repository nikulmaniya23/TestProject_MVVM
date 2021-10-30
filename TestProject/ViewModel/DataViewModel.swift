//
//  DataViewModel.swift
//  TestProject
//
//  Created by iMac on 27/10/21.
//


import UIKit

class DataViewModel {
    
    var datas: [MODEL_ACROMINE] = [MODEL_ACROMINE]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private var cellViewModels: [DataListCellViewModel] = [DataListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    //Call Api by given keyword
    func getData(keyword:String){
        showLoading?()
        
        apiManager.shared.callApiToGetFullForm(parameters: [:], keyword: keyword) { temp in
            self.hideLoading?()
            self.createCell(datas: temp!)
            self.reloadTableView?()
            
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        if indexPath.row>=cellViewModels.count{
            return DataListCellViewModel.init(titleText: "No Record Found", subTitleList: nil)
        }
        return cellViewModels[indexPath.row]
    }
    // CREATE CELL
    func createCell(datas: [MODEL_ACROMINE]){
        self.datas = datas
        if datas.count>0{
            var vms = [DataListCellViewModel]()
            for data in datas[0].lfs! {
                vms.append(DataListCellViewModel(titleText: data.lf!, subTitleList: data.vars!))
            }
            cellViewModels = vms
        }
        else{
            cellViewModels.removeAll()
        }
       
    }
}

struct DataListCellViewModel {
    let titleText: String
    let subTitleList: [VARS]?
}
