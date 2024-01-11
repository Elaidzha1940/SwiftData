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
   /* @Query(sort: \MyExpense.date)*/
    @Query(filter: #Predicate<MyExpense> { $0.value > 100 }, sort: \MyExpense.date)
    var expenses: [MyExpense]
    @Environment(\.modelContext) var context
    @State private var expenseToEdit: MyExpense?
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpensesCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                        // I don't need it anymore
                        //try! context.save()
                    }
                }
            }
            .navigationTitle("MyExpenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet, content: {
                AddExpenseSheet()
            })
            .sheet(item: $expenseToEdit) { expense in
                UpdateExpensesSheet(expense: expense)
            }
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
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
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
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Expense name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Value", value: $value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("New Expenses")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let expense = MyExpense(name: name, date: date, value: value)
                        context.insert(expense)
                        // SwiftData has a autosave.
                        //try! context.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

struct UpdateExpensesSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: MyExpense
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Expense name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Expenses")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
