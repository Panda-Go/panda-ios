//
//  SignInStep2ViewController.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class SignInStep2ViewController: KeyBoardViewController {
    
    @IBOutlet weak var digitTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    private var textFieldFilled = false
    private var digitNum = ""
    var phoneNumber = ""
    
    private var verificationResponse:VerificationResponse?
    private var pandaInfoResponse: PandaInfoResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        digitTextField.delegate = self
    }
    
    @IBAction func openMainButton(_ sender: Any) {
        requestVerification(phoneNumber: phoneNumber, code: digitNum)
    }
    
}

extension SignInStep2ViewController {
    func activateButton() {
        if textFieldFilled {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
    }
}

extension SignInStep2ViewController {
    func requestVerification(phoneNumber: String, code: String) {
        PandaGoProvider().getVerification(phoneNumber: phoneNumber, code: code, completion: { [weak self] data in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let verificationResponse = try decoder.decode(VerificationResponse.self, from: data)
                    self?.verificationResponse = verificationResponse
                } catch {
                    print("error: ", error)
                }
            }
            
            if self?.verificationResponse?.status == "approved" {
                self?.requestPandaInfo(phoneNumber: phoneNumber)
            }
        }) { error in
            print("error: ", error)
        }
    }
    
    func requestPandaInfo(phoneNumber: String) {
        PandaGoProvider().getPandaInfo(pandaId: phoneNumber, completion: { [weak self] data in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let pandaInfoResponse = try decoder.decode(PandaInfoResponse.self, from: data)
                    self?.pandaInfoResponse = pandaInfoResponse
                    
                } catch {
                    print("error: ", error)
                }
            }
            
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateInitialViewController() as! ViewController
                newViewController.modalPresentationStyle = .fullScreen
                newViewController.pandaInfo = self?.pandaInfoResponse
                self?.present(newViewController, animated: true, completion: nil)
            }
            
        }) { error in
            print("error: ", error)
        }
    }
    
}

extension SignInStep2ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            guard let text = textField.text else { return }
            textField.text = text.applyPatternOnNumbers(pattern: "   X        X       X       X       X       X", replacmentCharacter: "X")
            textFieldFilled = true
            digitNum = text.applyPatternOnNumbers(pattern: "XXXXXX", replacmentCharacter: "X")
            print(digitNum)
            print(phoneNumber)
        }
        else {
            textFieldFilled = false
        }
        activateButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedDigit(number: newString)

        return false
        
    }
}
