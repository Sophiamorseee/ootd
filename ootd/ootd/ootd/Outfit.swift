//
//  Outfit.swift
//  ootd
//
//  Created by Sophia Morse on 5/10/24.
//

import Foundation
import SwiftUI

struct Outfit: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let profileName: String // Add profileName property
}
