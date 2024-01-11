SwiftData - Model, @Query, @Bindable, #Predicate, Container, Fetch, Create, Update & Delete.
============================================================================================

https://github.com/Elaidzha1940/SwiftData/assets/64445918/fd28c81d-22f8-4cd5-a3a5-b136874e9007

@Query:
-------
``````ruby
@Query(sort: \MyExpense.date) var expenses: [MyExpense]
``````

``````ruby
@Query(filter: #Predicate<MyExpense> { $0.value > 100 }, sort: \MyExpense.date)
    var expenses: [MyExpense]
``````
