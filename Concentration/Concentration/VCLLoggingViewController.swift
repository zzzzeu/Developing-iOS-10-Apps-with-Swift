//
//  VCLLoggingViewController.swift
//  Concentration
//
//  Created by 总受 on 2019/2/21.
//  Copyright © 2019 com.zeu. All rights reserved.
//

import UIKit

class VCLLoggingViewController: UIViewController {

    private struct LogGlobals {
        var prefix = ""
        var instanceCounts = [String: Int]()
        var lastLogTime = Date()
        var indentationInterval: TimeInterval = 1
        var indentationSting = "__"
    }
    
    private static var logGlobals = LogGlobals()
    
    private static func logPrefix(for loggingName: String) -> String {
        if logGlobals.lastLogTime.timeIntervalSinceNow < -logGlobals.indentationInterval {
            logGlobals.prefix += logGlobals.indentationSting
            print("")
        }
        logGlobals.lastLogTime = Date()
        return logGlobals.prefix + loggingName
    }
    
    private static func bumpInstanceCount(for loggingfName: String) -> Int {
        logGlobals.instanceCounts[loggingfName] = (logGlobals.instanceCounts[loggingfName] ?? 0) + 1
        return logGlobals.instanceCounts[loggingfName]!
    }
    
    private var instanceCount: Int!
    
    var vclLoggingName: String {
        return String(describing: type(of: self))
    }
    
    private func logVCL(_ msg: String) {
        if instanceCount == nil {
            instanceCount = VCLLoggingViewController.bumpInstanceCount(for: vclLoggingName)
        }
        print("\(VCLLoggingViewController.logPrefix(for: vclLoggingName))(\(instanceCount!)) \(msg)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logVCL("init(coder:) - created via InterfaceByulder")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logVCL("init(nibName: bundle:) - create in code")
    }
    
    deinit {
        logVCL("left the heap")
    }
    
    override func awakeFromNib() {
        logVCL("awkeFromNib()")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logVCL("viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logVCL("viewWillAppear(animated = \(animated))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logVCL("viewDidAppear(animated = \(animated))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVCL("viewWillDisappear(animated = \(animated))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logVCL("viewDidDisappear(animated = \(animated))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logVCL("didReceiveMemoryWarning()")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVCL("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVCL("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        logVCL("viewWillTransition(to: \(size), with: coordinator")
        coordinator.animate(alongsideTransition: { (context:
            UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.logVCL("begin animate(alongsideTransition: completion)")
        }, completion: { context -> Void in
            self.logVCL("end animate(alongsideTransition: completion:)")
        })
    }
}
