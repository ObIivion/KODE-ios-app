//
//  NetworkMonitor.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 20.06.2022.
//

import Foundation
import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor

    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    
    private(set) var isConnected: Bool = true
    
    /// Возможные состояния могут быть `other`, `wifi`, `cellular`,
    /// `wiredEthernet`, or `loopback`

    private(set) var interfaceType: NWInterface.InterfaceType?
    
    
    private init(){
        self.monitor = NWPathMonitor()
        
    }
    
    func startMonitoring(){
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            
            self?.interfaceType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
        }
        
        monitor.start(queue: queue)
        
    }
    
    func stopMonitoring(){
        
        monitor.cancel()
        
    }
}

extension NWInterface.InterfaceType: CaseIterable {
    
    public static var allCases: [NWInterface.InterfaceType] = [
        .wiredEthernet,
        .wifi,
        .cellular,
        .loopback,
        .other
    ]
}
