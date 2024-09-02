//
//  Action.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

protocol AppAction {}

protocol FailureAppAction: AppAction {}

struct DummyAction: AppAction { }
