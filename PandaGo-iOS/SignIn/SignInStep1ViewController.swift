//
//  SignInStep1ViewController.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class SignInStep1ViewController: KeyBoardViewController {
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    private var textFieldFilled = false
    private var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryCodeTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        countryCodeTextField.attributedPlaceholder = NSAttributedString(string: "1",
        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5450980392, alpha: 1)])
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "(201) 555-0123",
        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5450980392, alpha: 1)])
    }

}

extension SignInStep1ViewController {
    func activateButton() {
        if textFieldFilled {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
    }
}

extension SignInStep1ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if countryCodeTextField.text != "" && phoneNumberTextField.text != "" {
            phoneNumber = countryCodeTextField.text!
            guard let text = phoneNumberTextField.text else { return }
            phoneNumber += text.applyPatternOnNumbers(pattern: "##########", replacmentCharacter: "#")
            
            textFieldFilled = true
        }
        else {
            textFieldFilled = false
        }
        activateButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = formattedNumber(number: newString)
            print(phoneNumber)
            return false
        }
        else {
            return true
        }
    }
}
