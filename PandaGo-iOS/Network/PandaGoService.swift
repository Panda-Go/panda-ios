//
//  PandaGoService.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import Foundation
import Moya

enum PandaGoService {
    case getLoginOTP(_ phoneNumber:String)
    case getVerification(_ phoneNumber: String, _ code: String)
    case getPandaInfo(_ pandaId: String)
}

extension PandaGoService:TargetType {
    var sampleData: Data {
        return Data()
    }

    var baseURL: URL { return URL(string: "http://ec2-3-21-169-37.us-east-2.compute.amazonaws.com:3000")!}
    var path: String { // 서버에 던져줄 주소 값
        switch self {
        case .getLoginOTP(let phoneNumber):
            return "/twilio/login"
        case .getVerification(let phoneNumber, let code):
            return "/twilio/verify"
        case .getPandaInfo(let pandaId):
            return "/panda/info"
        }
    }
    
    var method: Moya.Method { // get, post, put, delete
        switch self {
        case .getLoginOTP, .getVerification, .getPandaInfo:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getLoginOTP(let phoneNumber):  // Always sends parameters in URL, regardless of which HTTP method is used
            return .requestParameters(parameters: ["phoneNumber": phoneNumber], encoding: URLEncoding.queryString)
        case .getVerification(let phoneNumber, let code):
            return .requestParameters(parameters: ["phoneNumber": phoneNumber, "code":code], encoding: URLEncoding.queryString)
        case .getPandaInfo(let pandaId):
            return .requestParameters(parameters: ["pandaId": pandaId], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

