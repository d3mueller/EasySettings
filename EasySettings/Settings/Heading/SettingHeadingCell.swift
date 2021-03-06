//
//  SettingHeadingCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 18.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

internal protocol SettingHeadingCellDelegate: class {
    
}

extension Setting {
    internal class HeadingCell: SwipeCell, ListBindable {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        internal weak var delegate: SettingHeadingCellDelegate?
        private var listModel: Setting.HeadingModel?
        
        // swipe action buttons
        override var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        internal lazy var label: UILabel = {
            let label = UILabel()
            label.font = SettingsPage.Style.defaultBoldFont.withSize(24)
            label.minimumScaleFactor = 0.6
            label.textColor = UIColor(hex: 0xeeeeee)
            
            holderView.addSubview(label)
            return label
        }()
        
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            label.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            }
            
        }
        
        required internal init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        internal func configure(withListModel listModel: Setting.HeadingModel) {
            self.listModel = listModel
            label.text = listModel.text
        }
        
        internal func bindViewModel(_ viewModel: Any) {
            guard let viewModel = viewModel as? Setting.HeadingModel else { return }
            configure(withListModel: viewModel)
        }
        // ====================
        
        
    }
}

