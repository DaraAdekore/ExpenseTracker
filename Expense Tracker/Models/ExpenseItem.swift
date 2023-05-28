//
//  ExpenseItem.swift
//  Expense Tracker
//
//  Created by Dara Adekore on 2023-05-27.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
