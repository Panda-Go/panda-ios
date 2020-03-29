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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        digitTextField.delegate = self
    }
    
    @IBAction func openMainButton(_ sender: Any) {
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

extension SignInStep2ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            guard let text = textField.text else { return }
            textField.text = text.applyPatternOnNumbers(pattern: "   X       X       X       X       X       X", replacmentCharacter: "X")
            textFieldFilled = true
            
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
