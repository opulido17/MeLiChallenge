//
//  NetworkMonitor.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import Network
import UIKit

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    weak var delegate: NetworkMonitorDelegate?
    
    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    private var status: NWPath.Status?
    
    func start() {
        monitor?.cancel()
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status != self.status {
                self.status = pathUpdateHandler.status
                DispatchQueue.main.async {
                    self.delegate?.networkMonitor(didChangeStatus: pathUpdateHandler.status)
                    if pathUpdateHandler.status != .satisfied {
                        //self.showNetworkErrorMessage()
                    }
                }
            }
        }
        monitor?.start(queue: queue)
    }
    
    func stop() {
        monitor?.cancel()
    }
    
    func isNetworkAvailable() -> Bool {
        if status != .satisfied {
            //showNetworkErrorMessage()
            return false
        }
        return true
    }
    
//    private func showNetworkErrorMessage() {
//        ErrorAlertView(isPresented: true, text: <#T##String#>, image: <#T##Image?#>, confirm: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, cancel: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//    }
}

protocol NetworkMonitorDelegate: AnyObject {
    func networkMonitor(didChangeStatus status: NWPath.Status)
}
