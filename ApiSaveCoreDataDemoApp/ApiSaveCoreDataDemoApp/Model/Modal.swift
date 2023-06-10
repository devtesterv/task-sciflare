//
//  Modal.swift
//  corepopularmovi
//
//  Created by CV on 9/6/22.
//

import Foundation
import Foundation
struct UnicornData : Codable {
    let id : String?
    let name : String?
    let age : Int?
    let colour : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case age = "age"
        case colour = "colour"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        colour = try values.decodeIfPresent(String.self, forKey: .colour)
    }

}
