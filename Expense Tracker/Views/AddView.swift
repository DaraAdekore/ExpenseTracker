//
//  AddView.swift
//  Expense Tracker
//
//  Created by Dara Adekore on 2023-05-27.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses:Expenses
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = ExpenseType.Personal
    @State private var amount = 0.0
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(ExpenseType.allCases.dropFirst(), id: \.self){
                        Text("\($0.rawValue)")
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save"){
                    if !name.isEmpty, !amount.isZero{
                        let item = ExpenseItem(name: name, type: type.rawValue, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
