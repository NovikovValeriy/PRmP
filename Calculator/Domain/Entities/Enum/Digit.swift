//
//  Digit.swift
//  Calculator
//
//  Created by Валерий Новиков on 7.02.25.
//

import Foundation

enum Digit: Int  {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}
