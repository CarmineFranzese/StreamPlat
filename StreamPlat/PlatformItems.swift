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
    var colorHex: String
    
    var color: Color {
        get {
            Color(hex: colorHex) ?? .black
        }
        set {
            colorHex = newValue.toHex() ?? "#000000"
        }
    }
    
    init(title: String = "", info: String = "", date: Date = .now, colorHex: String = "#000000") {
        self.title = title
        self.info = info
        self.date = date
        self.colorHex = colorHex
    }
}
