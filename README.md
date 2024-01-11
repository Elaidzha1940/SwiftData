SwiftData - Model, @Query, @Bindable, Container, Fetch, Create, Update & Delete.
=============================================================

@Query:
-------
``````ruby
 @Query(sort: \MyExpense.date) var expenses: [MyExpense]
``````

``````ruby
@Query(filter: #Predicate<MyExpense> { $0.value > 100 }, sort: \MyExpense.date)
    var expenses: [MyExpense]
``````
