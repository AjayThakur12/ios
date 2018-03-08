//
//  ServerRoute.swift
//  AmahiAnywhere
//
//  Created by Chirag Maheshwari on 07/03/18.
//  Copyright © 2018 Amahi. All rights reserved.
//

import EVReflection
import Foundation


@objc(ServerRoute)
public class ServerRoute: EVNetworkingObject {
    
    public var local_addr: String? =    nil
    public var relay_addr: String? =   nil
}

