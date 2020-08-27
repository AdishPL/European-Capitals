//
//  DetailsListViewModel.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 21/08/2020.
//

import Foundation

enum CellType {
    case capitalCellType
    case detailsCellType
}

class DetailsListViewModel {
    private let apiClient: APIClientProtocol
    private let favoritesManager: FavoritesManager
    
    private var capital: Capital
    
    private(set) var details: CapitalDetails?
    private(set) var info: CityInfo?

    var cells: [CellType] {
        guard info != nil else { return [.capitalCellType] }
        return [.capitalCellType, .detailsCellType, .detailsCellType, .detailsCellType]
    }

    private(set) var error: APIError? {
        didSet {
            /// TODO: present error message
        }
    }
    
    var numberOfRows: Int {
        return cells.count
    }

    var name: String {
        return capital.name
    }
    
    var mainPhotoKey: String {
        return capital.photoKey
    }
    
    init(for capital: Capital,
         apiClient: APIClientProtocol = APIClient(),
         favoritesManager: FavoritesManager = FavoritesManager()) {
        self.capital = capital
        self.apiClient = apiClient
        self.favoritesManager = favoritesManager
    }
    
    func cellType(forIndexPath indexPath: IndexPath) -> CellType {
        return cells[indexPath.row]
    }
    
    func configureCapitalCell(_ cell: CapitalTableViewCell, atIndex index: Int) {
        cell.configure(with: capital)
    }
    
    func configureDetailsCell(_ cell: DetailsTableViewCell, atIndex index: Int) {
        if let details = details {
            switch index {
            case 1:
                cell.configureWith(leftText: AppStrings.area,
                                   rightText: details.area)
            case 2:
                cell.configureWith(leftText: AppStrings.population,
                                   rightText: details.population)
            default:
                cell.configureWith(leftText: AppStrings.timeZone, rightText:
                                    details.timeZone)
            }
        }
    }

    func toggleFavorite(atIndex index: Int) {
        /// Update local storage
        favoritesManager.toggleFavorite(capital.identifier)
    }
}

// MARK: - API calls

extension DetailsListViewModel {
    func loadAllData(_ completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        loadDetails {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadMoreInfo {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func loadDetails(_ completion: @escaping () -> Void) {
        apiClient.request(
            target: .getDetails,
            type: CapitalDetails.self
        ) { [weak self] (result) in
            switch result {
            case .success(let details):
                self?.details = details
            case .failure(let error):
                self?.error = error
            }
            completion()
        }
    }
    
    func loadMoreInfo(_ completion: @escaping () -> Void) {
        apiClient.request(
            target: .getMoreInfo,
            type: CityInfo.self
        ) { [weak self] (result) in
            switch result {
            case .success(let info):
                self?.info = info
            case .failure(let error):
                self?.error = error
            }
            completion()
        }
    }
}
