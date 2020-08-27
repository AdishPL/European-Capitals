//
//  MasterListViewModel.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import Foundation

class MasterListViewModel {
    private let apiClient: APIClientProtocol
    private let favoritesManager: FavoritesManagerProtocol
    
    var items: Capitals = [] {
        didSet {
            for (index, city) in items.enumerated() {
                if favoritesManager.favorites.contains(city.identifier) {
                    items[index].isFavorite = true
                }
            }
        }
    }
    
    var showFavorites: Bool = false
    
    var error: APIError? {
        didSet {
            /// TODO: present error message
        }
    }
    
    var numberOfRows: Int {
        if showFavorites {
            return items.filter({ $0.isFavorite }).count
        }
        return items.count
    }
    
    init(apiClient: APIClientProtocol = APIClient(),
         favoritesManager: FavoritesManagerProtocol = FavoritesManager()) {
        self.apiClient = apiClient
        self.favoritesManager = favoritesManager
    }
    
    func item(atIndex index: Int) -> Capital? {
        if showFavorites {
            return items.filter({ $0.isFavorite })[safe: index]
        }
        return items[safe: index]
    }
    
    func configure(_ cell: CapitalTableViewCell, atIndex index: Int) {
        if let capital = item(atIndex: index) {
            cell.configure(with: capital)
        }
    }
    
    func toggleFavorite(atIndex index: Int) {
        if let capital = item(atIndex: index) {
            /// Update local storage
            favoritesManager.toggleFavorite(capital.identifier)
            
            var updatedCapital = capital
            updatedCapital.isFavorite = !updatedCapital.isFavorite
            if let updatedItemIndex = items.firstIndex(where: { $0.identifier == updatedCapital.identifier }) {
                items[updatedItemIndex] = updatedCapital
            }
        }
    }
}

// MARK: - API calls

extension MasterListViewModel {
    func loadCapitals(_ completion: @escaping () -> Void) {
        apiClient.request(
            target: .getCapitals,
            type: Capitals.self
        ) { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.items = items
            case .failure(let error):
                self?.error = error
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
