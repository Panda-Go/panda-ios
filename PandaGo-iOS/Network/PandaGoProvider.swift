//
//  PandaGoProvider.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import Foundation
import Moya
//import Result

class PandaGoProvider {
    let provider = MoyaProvider<PandaGoService>()

    func getLoginOTP(phoneNumber: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getLoginOTP(phoneNumber: phoneNumber)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func getVerification(phoneNumber: String, code: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getVerification(phoneNumber: phoneNumber, code: code)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func getPandaInfo(pandaId: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getPandaInfo(pandaId: pandaId)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func getFriendList(pandaId: String?, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getFriendList(pandaId: nil)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func updateFightResult(winner: String, loser: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.updateFightResult(winner: winner, loser: loser)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func updateWeapon(phoneNumber: String, weapon: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.updateWeapon(phoneNumber: phoneNumber, weapon: weapon)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func getWashHandSMS(phoneNumber: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getWashHandSMS(phoneNumber: phoneNumber)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func getWarningSMS(phoneNumber: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getWarningSMS(phoneNumber: phoneNumber)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
}

extension PandaGoProvider {
    func resultTask(_ result: Result<Response, MoyaError>, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        switch result {
        case let .success(response):
            let data = response.data
            let statusCode = response.statusCode
            if statusCode >= 300 {
                failure(MoyaError.statusCode(response))
            } else {
                completion(data)
            }
        case let .failure(error):
            failure(error)
        }
    }
}
