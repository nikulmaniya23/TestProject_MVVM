//
//  File.swift
//  TestProject
//
//  Created by iMac on 28/10/21.
//

import Foundation

// MARK: - Temperature
struct MODEL_ACROMINE: Codable {
    let sf: String?
    let lfs: [LF]?
}

// MARK: - LF
struct LF: Codable {
    let lf: String?
    let freq, since: Int?
    let vars: [VARS]?
}
struct VARS: Codable {
    let lf: String?
    let freq, since: Int?
}
typealias MODEL_ACROMINES = [MODEL_ACROMINE]
