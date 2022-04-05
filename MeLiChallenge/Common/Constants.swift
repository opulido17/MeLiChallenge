//
//  Constants.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 22/03/22.
//

import Foundation
import SwiftUI

public enum Constants {
    static let serviceStatusCodeOk = 200...299
    
    static let serv_url_base = "https://api.mercadolibre.com/"
    static let serv_getProductSearch = "sites/MCO/search?q={search}&limit={limit}"
    static let serv_getCategory = "sites/MCO/categories"
    static let serv_getDescription = "items/{itemId}/description"
    static let serv_getSellerInfo = "sites/MCO/search?seller_id={sellerId}&limit=15"
    static let serv_getProductsByCategory = "sites/MCO/search?category={categoryId}"
    
    // MARK: - DefaultImage
    static let defaultImage = "https://cdn1.iconfinder.com/data/icons/business-company-1/500/image-512.png"
    static let imageErrorServiceGeneral = "errorServiceGeneral"
    
    // MARK: - Message Error
    static let messageErrorGeneric = "En estos momentos la funcionalidad no está disponible. Por favor, ingresa más tarde."
    static let messageErrorDescription = "Hemos tenido inconvenientes para obtener la descripción de este producto, por favor, intentelo mas tarde."
    static let messageErrorSeller = "Hemos tenido inconvenientes para obtener la información de su vendedor, por favor, intentelo mas tarde."
}
