//
//  PlatformItems.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 10/12/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class PlatformItems {
    var title: String
    var info: String
    var date: Date
    //var isCompleted: Bool
    var reminder: [String] = []
    
    init(title: String = "", info: String = "", date: Date = .now, /*isCompleted: Bool = false, */reminder: [String] = []){
        self.title = title
        self.info = info
        self.date = date
        //self.isCompleted = isCompleted
        self.reminder = reminder
    }
}
