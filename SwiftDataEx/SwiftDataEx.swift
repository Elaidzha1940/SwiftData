//  /*
//
//  Project: SwiftDataEx
//  File: SwiftDataEx.swift
//  Created by: Elaidzha Shchukin
//  Date: 10.01.2024
//
//  */

import SwiftUI
import SwiftData

struct SwiftDataEx: View {
    @State private var isShowingItemSheet: Bool = false
    var expenses: [MyExpense] = []
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpensesCell(expense: expense)
                }
            }
            .navigationTitle("MyExpenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet, content: {
                AddExpenseSheet()
            })
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus") {
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portraits")
                    }, description: {
                        Text("Start adding expense to see your list.")
                    }, actions: {
                        Button("Add Expense") { isShowingItemSheet = true}
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    SwiftDataEx()
}

struct ExpensesCell: View {
    let expense: MyExpense
    
    var body: some View {
        HStack {
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "BTC"))
        }
    }
}

struct AddExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    var body: some View {
        
        let formStyle = FormStyleConfiguration()

        NavigationStack {
            Form {
                TextField("Expense name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Value", text: $value, format: .currency(code: "BTC"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("New Expenses")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss
                    }
                }
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Save") {
                        let expense = MyExpense(name: name, date: date, value: value)
                    }
                }
            }
        }
    }
}
