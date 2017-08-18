//
//  RealmStorageContext.swift
//  EMBreakDepedencyRealm
//
//  Created by Ennio Masi on 10/07/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation
import RealmSwift

/// Storage config options
///
/// - basic: Local Realm file.
/// - inMemory: in-memory Realm
public enum ConfigurationType {
    case basic(url: String?)
    case inMemory(identifier: String?)

    var associated: String? {
        get {
            switch self {
            case .basic(let url): return url
            case .inMemory(let identifier): return identifier
            }
        }
    }
}

/// Realm STorageContext
class RealmStorageContext: StorageContext {
    var realm: Realm?

    /// Init
    ///
    /// - Parameter configuration: Config
    /// - Throws: An `NSError` if the Realm could not be initialized.
    required init(configuration: ConfigurationType = .basic(url: nil)) throws {
        var rmConfig = Realm.Configuration()
        rmConfig.readOnly = true
        switch configuration {
        case .basic:
            rmConfig = Realm.Configuration.defaultConfiguration
            if let url = configuration.associated {
                rmConfig.fileURL = NSURL(string: url) as URL?
            }
        case .inMemory:
            rmConfig = Realm.Configuration()
            if let identifier = configuration.associated {
                rmConfig.inMemoryIdentifier = identifier
            } else {
                throw NSError()
            }
        }
        try self.realm = Realm(configuration: rmConfig)
    }

    /// Performs actions contained within the given block inside a write transaction.
    ///
    /// - Parameter block: The block containing actions to perform
    /// - Throws: An `NSError` if the transaction could not be completed successfully.
    ///     If `block` throws, the function throws the propagated `ErrorType` instead.
    public func safeWrite(_ block: (() throws -> Void)) throws {
        guard let realm = self.realm else {
            throw NSError()
        }

        if realm.isInWriteTransaction {
            try block()
        } else {
            try realm.write(block)
        }
    }
}
