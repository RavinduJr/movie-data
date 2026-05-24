//
//  AppRouter.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import SwiftUI
import Combine

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
