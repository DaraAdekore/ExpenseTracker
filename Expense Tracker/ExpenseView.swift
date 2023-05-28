//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Dara Adekore on 2023-05-27.
//

import SwiftUI

struct ExpenseView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var filteredExpenses = [ExpenseItem]()
    @State private var filteredBy = ExpenseType.All
    @AppStorage("localCurrency") private var currencyCode:String = "USD"
    var body: some View {
        NavigationView{
            VStack{
                
                    HStack{
                        Picker(selection: $currencyCode){
                            ForEach(Locale.commonISOCurrencyCodes, id:\.self){
                                Text($0)
                            }
                        } label: {
                            Text("Currency")
                        }
                        Spacer()
                        Picker("filter by",selection: $filteredBy){
                            ForEach(ExpenseType.allCases, id:\.self) { expense in
                                Text(expense.rawValue)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width:100 ,height: 50,alignment: .center)
                        Spacer()
                        Button {
                            showingAddExpense = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        Spacer()
                    }
                    List{
                        
                        ForEach(
                            filteredBy != .All ? expenses.items.filter({item in
                                return item.type == filteredBy.rawValue
                            }):
                                expenses.items
                        ){item in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                switch item.amount {
                                case 0...10:
                                    Text(item.amount,format: .currency(code: currencyCode))
                                    
                                case 11...100:
                                    Text(item.amount,format: .currency(code: currencyCode))
                                        .font(.system(size: 18,weight: .medium))
                                case 101...:
                                    Text(item.amount,format: .currency(code: currencyCode))
                                        .font(.system(size: 24,weight: .heavy))
                                default:
                                    Text(item.amount,format: .currency(code: currencyCode))
                                    
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                    .navigationTitle("Expense Tracker")
                    .navigationBarTitleDisplayMode(.inline)
                                .font(.custom("Snell Roundhand", size: 24))
                    .background(Color.clear)
                    .sheet(isPresented: $showingAddExpense){
                        AddView(expenses: expenses)
                    }
                }
            }
        }
    func removeItems(at offsets:IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}


