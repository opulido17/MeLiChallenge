//
//  NetworkingResult.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import Foundation

enum NetworkingResult<SuccessValue, FailureValue> {
    case success(SuccessValue)
    case failure(FailureValue)
}
