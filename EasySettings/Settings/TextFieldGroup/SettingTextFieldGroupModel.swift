//
//  SettingTextFieldGroupModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 17.09.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingTextFieldGroupConfiguration {
    func configured(_ setting: Setting.TextFieldGroup) -> Setting.TextFieldGroup
}

extension Setting {
    typealias TextFieldGroup = TextFieldGroupModel
    class TextFieldGroupModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var items: [TextField] = []
        
        /// Has to sum to 1
        public var relativeTextFieldWidths: [CGFloat] = []
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(_ id: String) {
            super.init(id)
            
            // height of each item
            height = 40
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override var sectionController: ListSectionController {
            let section = Setting.TextFieldGroupSection()
            
            // In binding section controllers, there is no 'didUpdate(to:)' method. Inset needs to be set here.
            section.inset = inset
            
            return section
        }
        
        override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.TextFieldGroupModel, super.isEqual(toDiffableObject: object) else { return false }
            return true
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
