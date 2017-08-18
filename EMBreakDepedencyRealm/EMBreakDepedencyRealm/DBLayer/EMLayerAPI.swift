//
//  EMLayerAPI.swift
//  EMBreakDepedencyRealm
//
//  Created by Ennio Masi on 10/07/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation

/// Sorted
struct Sorted {
    var key: String
    var ascending: Bool = true
}

/// Operations on context
protocol StorageContext {

    /// Create a new object with default values
    ///
    /// - Parameters:
    ///   - model: Model type
    ///   - completion: Completion block
    /// - Returns: An object that is conformed to the `Storable` protocol
    /// - Throws:
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws

    /// Save an object that is conformed to the `Storable` protocol
    ///
    /// - Parameter object: Object
    /// - Throws:
    func save(object: Storable) throws

    /// Update an object that is conformed to the `Storable` protocol
    ///
    /// - Parameter block: Completion block
    /// - Throws:
    func update(block: @escaping () -> Void) throws
    /*
     Delete an object that is conformed to the `Storable` protocol
     */
    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    func delete(object: Storable) throws

    /// Delete all objects that are conformed to the `Storable` protocol
    ///
    /// - Parameter model: Model type
    /// - Throws:
    func deleteAll<T: Storable>(_ model: T.Type) throws

    /// Return a list of objects that are conformed to the `Storable` protocol
    ///
    /// - Parameters:
    ///   - model: Object type
    ///   - predicate: Predicate
    ///   - sorted: Sorted params
    ///   - completion: Completion block
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> Void))
}
