//
//  AlertConfiguration.swift
//
//
//  Created by Kai Shao on 2023/12/11.
//

import SwiftUI

public struct AlertConfiguration {
    var enableBackgroundBlur: Bool = true
    var disableOutsideTap: Bool = true
    var transitionType: TransitionType = .slide
    var slideEdge: Edge = .bottom
    public var show: Bool = false
    var showView: Bool = false
    
    public init(enableBackgroundBlur: Bool = true, disableOutsideTap: Bool = true, transitionType: TransitionType = .slide, slideEdge: Edge = .bottom) {
        self.enableBackgroundBlur = enableBackgroundBlur
        self.disableOutsideTap = disableOutsideTap
        self.transitionType = transitionType
        self.slideEdge = slideEdge
    }
    
    /// TransitionType
    public enum TransitionType {
        case slide
        case opacity
    }
    
    /// Alert Present/Dismiss Methods
    mutating
    public func present() {
        show = true
    }
    
    public mutating
    func dismiss() {
        show = false
    }
}
