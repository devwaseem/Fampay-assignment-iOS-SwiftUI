//
//  AnyError.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 01/07/21.
//

import Foundation

//type erasure for error
struct AnyError: Error, LocalizedError {
    
    var errorDescription: String
    
    init(error: Error) {
        self.errorDescription = error.localizedDescription
    }
    
}
