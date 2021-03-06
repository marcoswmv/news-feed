//
//  UIViewWithXib.swift
//  ActiveCitizen
//
//  Created by Marcos Vicente on 03.12.2019.
//

import UIKit

/// Load view with xib file.
@IBDesignable
class UIViewWithXib: UIView {
    
    @IBOutlet var view: UIView! {
        didSet {
            setup()
        }
    }
    
    private var isSetup = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        if isSetup { return }
        
        isSetup = true
        
        // 1. load the interface
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        // 2. add as subview
        self.addSubview(self.view)
        // 3. allow for autolayout
        self.view.translatesAutoresizingMaskIntoConstraints = false
        // 4. add constraints to span entire view
        self.setHorizontalConstraints(to: view)
        self.setVerticalConstraints(to: view)
    }
}
