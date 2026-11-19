//
//  Order.swift
//  CupcakeCorner
//
//  Created by Kelsey Steven on 11/18/26.
//

import Foundation




@Observable
class Order: Codable {
    enum CakeType: String, Codable, CaseIterable, Identifiable {
        var id: Self { self }

        case vanilla = "Vanilla"
        case chocolate = "Chocolate"
        case strawberry = "Strawberry"
        case rainbow = "Rainbow"
        
        var price: Decimal {
                switch self {
                case .strawberry:
                    return 3.00
                case .rainbow:
                    return 4.00
                default:
                    return 2.00
                }
            }
    }
    
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var type: CakeType = .vanilla
    var quantity = 3
    var addExtraFrosting = false
    var addSprinkles = false

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                addSprinkles = false
                addExtraFrosting = false
            }
        }
    }

    var isAddressValid: Bool {
        let anyFieldsEmpty = name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty
        return anyFieldsEmpty ? false : true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += type.price
        
        // $1/cake for extra frosting
        if addExtraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    enum Codingkeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
}
