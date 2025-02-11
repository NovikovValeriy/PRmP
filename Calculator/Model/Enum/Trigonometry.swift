//
//  Trigonometry.swift
//  Calculator
//
//  Created by Валерий Новиков on 11.02.25.
//

enum Trigonometry {
    case sine, cosine, tangent, cotangent
    
    var description: String {
        switch self {
        case .sine:
            return "sin"
        case .cosine: 
            return "cos"
        case .tangent: 
            return "tan"
        case .cotangent: 
            return "cot"
        }
    }
}
