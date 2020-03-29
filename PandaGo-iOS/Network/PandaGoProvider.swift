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
        provider.request(.getLoginOTP(phoneNumber)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func getVerification(phoneNumber: String, code: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getVerification(phoneNumber, code)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func getPandaInfo(pandaId: String, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.getPandaInfo(pandaId)) { result in
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
