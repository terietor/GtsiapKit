//
//  FormStringTextFieldView.swift
//  GtsiapKit
//
//  Created by Giorgos Tsiapaliokas on 23/10/15.
//  Copyright © 2015 Giorgos Tsiapaliokas. All rights reserved.
//

import UIKit

public class FormStringTextFieldView: FormTextFieldView<String> {
    public override init(title: String, placeHolder: String, description: String?) {
        super.init(title: title, placeHolder: placeHolder, description: description)
        self.keyboardType = .Default
        self.errorable = self
    }

}

extension FormStringTextFieldView: FormTextFieldViewErrorable {
    public func hasError(string: String) -> (Bool, String) {
        return (false, "")
    }

}
