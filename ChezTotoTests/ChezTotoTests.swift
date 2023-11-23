//
//  ChezTotoTests.swift
//  ChezTotoTests
//
//  Created by N N on 23/11/2023.
//

import XCTest
@testable import ChezToto // Import the module where your ViewModel resides (@testable import ChezToto) to access the classes from your project within your test file.

final class ChezTotoTests: XCTestCase {

    var viewModel: ViewModel!

    // Test the ViewModel's initialization and its initial state:
    override func setUpWithError() throws {
        super.setUp()
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetDataLoadsData() {
        // Given
        viewModel = ViewModel() // Re-initialize ViewModel
        // When
        let data: [TypeOfDish] = ModelData().load("Source.json")
        viewModel.getData()
        // Then
        XCTAssertEqual(viewModel.menuArray.count, data.count, "Loaded data count should match menuArray count")
        // You might want to add more assertions here to check the content of menuArray if necessary
    }

    // Test initialization:
    func testViewModelInitialization() {
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.menuArray.count, 2, "Initial count of types of dishes should be 2")
    }

    // Test Adding a Dish:
    func testAddDish() {
        // Given
        let viewModel = ViewModel() // Re-initialize ViewModel
        let dish = Dish(name: "NewDish", description: "Description", price: 15)
        viewModel.addNewTypeOfDish(typeOfDish: "TestDish")
        // When
        viewModel.addDish(dish: dish, typeOfDish: "TestDish")
        // Then
        XCTAssertEqual(viewModel.menuArray.first(where: { $0.name == "TestDish" })?.dishs.count, 1)
        XCTAssertEqual(viewModel.menuArray.first(where: { $0.name == "TestDish" })?.dishs.first?.name, "NewDish")
    }

    // Test Adding a New Type of Dish:
    func testAddNewTypeOfDish() {
        let viewModel = ViewModel()
        viewModel.addNewTypeOfDish(typeOfDish: "NewTypeOfDish")
        XCTAssertEqual(viewModel.menuArray.count, 3, "Count should increase after adding a new type of dish")
    }

   // Test Adding a Dish to an Existing Type:
    func testAddDishToExistingType() {
        let viewModel = ViewModel()
        let dish = Dish(name: "NewDish", description: "Description", price: 13)
        viewModel.addDish(dish: dish, typeOfDish: "Entrées")
        XCTAssertEqual(viewModel.menuArray.first(where: { $0.name == "Entrées" })?.dishs.count, 3, "Count of dishes in 'Entrées' should increase after adding a dish")
    }

    // Test Removing a Dish:
    // Fails: "testRemoveDish(): XCTAssertEqual failed: ("4") is not equal to ("3") - Count of dishes in 'Pizzas' should decrease after removing a dish"
    func testRemoveDish() {
        let viewModel = ViewModel()
        // Count of dishes in 'Pizzas' before removal
        let initialCount = viewModel.menuArray.first(where: { $0.name == "Pizzas" })?.dishs.count ?? 0
        print("Initial count of dishes in 'Pizzas': \(initialCount)")
        // When
        viewModel.removeDish(dishName: "Margarita") // Remove a dish from "Pizzas"
        // Count of dishes in 'Pizzas' after removal
        let finalCount = viewModel.menuArray.first(where: { $0.name == "Pizzas" })?.dishs.count ?? 0
        print("Final count of dishes in 'Pizzas': \(finalCount)")
        // Then
        XCTAssertEqual(finalCount, initialCount - 1, "Count of dishes in 'Pizzas' should decrease after removing a dish")
    }

    //    override func setUpWithError() throws {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDownWithError() throws {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    //
    //    func testExample() throws {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //        // Any test you write for XCTest can be annotated as throws and async.
    //        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    //        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
}
