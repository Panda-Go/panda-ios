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
    case getLoginOTP(phoneNumber:String)
    case getVerification(phoneNumber: String, code: String)
    case getPandaInfo(pandaId: String)
    case getFriendList(pandaId: String?)
    case updateFightResult(winner: String, loser: String)
    case updateWeapon(phoneNumber: String, weapon: String)
    case getWarningSMS(phoneNumber: String)
    case getWashHandSMS(phoneNumber: String)
}

extension PandaGoService:TargetType {
    var sampleData: Data {
        return Data()
    }

    var baseURL: URL { return URL(string: "http://ec2-18-219-77-8.us-east-2.compute.amazonaws.com:3000")!}
    var path: String { // 서버에 던져줄 주소 값
        switch self {
        case .getLoginOTP:
            return "/twilio/login"
        case .getVerification:
            return "/twilio/verify"
        case .getPandaInfo:
            return "/panda/info"
        case .getFriendList:
            return "/panda/get_all_pandas"
        case .updateFightResult:
            return "/panda/fight"
        case .updateWeapon:
            return "/panda/update/weapon"
        case .getWarningSMS:
            return "/twilio/notify/warning"
        case .getWashHandSMS:
            return "/twilio/notify/wash"

        }
    }
    
    var method: Moya.Method { // get, post, put, delete
        switch self {
        case .getLoginOTP, .getVerification, .getPandaInfo, .getFriendList, .getWashHandSMS, .getWarningSMS:
            return .get
        case .updateFightResult, .updateWeapon:
            return .put
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
        case .getFriendList:
            return .requestPlain
        case .updateFightResult(let winner, let loser):
            return .requestParameters(parameters: ["winner": winner, "loser": loser], encoding: JSONEncoding.default)
        case .updateWeapon(let phoneNumber, let weapon):
            return .requestParameters(parameters: ["weapon": weapon, "pandaId":phoneNumber], encoding: JSONEncoding.default)
        case .getWashHandSMS(let phoneNumber):
            return .requestParameters(parameters: ["phoneNumber":phoneNumber], encoding: URLEncoding.queryString)
        case .getWarningSMS(let phoneNumber):
            return .requestParameters(parameters: ["phoneNumber": phoneNumber], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

