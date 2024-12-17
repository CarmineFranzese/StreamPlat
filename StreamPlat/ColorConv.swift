//
//  ColorConv.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 17/12/24.
//

import Foundation
import SwiftUI

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
    
    func toHex() -> String? {
        let components = UIColor(self).cgColor.components
        guard let r = components?[0], let g = components?[1], let b = components?[2] else { return nil }
        let red = Int(r * 255.0)
        let green = Int(g * 255.0)
        let blue = Int(b * 255.0)
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
