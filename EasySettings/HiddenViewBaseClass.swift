//
//  HiddenViewBaseClass.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 15.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit

extension SettingsPage {
    open class HiddenViewBaseClass: UIViewController, ListAdapterDataSource {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        open var hiddenSettings: [SettingExtension] {
            return []
        }
        
        public var hiddenSettingsHeight: CGFloat {
            var height: CGFloat = 0
            for setting in hiddenSettings {
                height += setting.heightSum
            }
            
            if let last = hiddenSettings.last {
                height -= last.inset.bottom
            }
            
            return height
        }
        
        lazy var collectionView: UICollectionView = {
            let layout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: true)
            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.backgroundColor = .clear
            view.alwaysBounceVertical = false
            view.alwaysBounceHorizontal = false
            self.view.addSubview(view)
            adapter.collectionView = view
            adapter.dataSource = self
            return view
        }()
        
        lazy var adapter: ListAdapter = {
            return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override open func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        
        public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
            let objects = hiddenSettings
            objects.last?.inset.bottom = 0
            
            return objects
        }
        
        public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
            guard let object = object as? SettingExtension else { fatalError() }
            return object.sectionController
        }
        
        public func emptyView(for listAdapter: ListAdapter) -> UIView? {
            return nil
        }
        // ====================
        
    }

}
