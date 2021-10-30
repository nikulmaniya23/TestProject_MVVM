//
//  File.swift
//  TestProject
//
//  Created by iMac on 27/10/21.
//

import Foundation
class apiManager{
    static let shared = apiManager()
    func callApiToGetFullForm(parameters:[String:String],keyword:String, completionHandler: @escaping ([MODEL_ACROMINE]?) -> Swift.Void) {

        var path = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(keyword)"
        path = path.replacingOccurrences(of: " ", with: "%20")
        let gitUrl = URL(string: path)
        let request = NSMutableURLRequest(url: gitUrl!)

        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in

            guard let data = data else { return }
            do {
                let gitData = try JSONDecoder().decode([MODEL_ACROMINE].self, from: data)
                print("response data:", gitData)
                completionHandler(gitData)
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}
