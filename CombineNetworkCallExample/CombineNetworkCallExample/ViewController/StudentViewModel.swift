//
//  StudentViewModel.swift
//  CombineNetworkCallExample
//
//  Created by Vidhyapathi on 17/11/24.
//

import UIKit

class StudentViewModel: NSObject {
    let networkManager = NetworkManager()
    
    var userList: [UserResponseMain]?
    
    func fetchUserInfo(completionHandler: @escaping ( _ error: String?) -> Void) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users") {
            
            networkManager.makeNetWorkCall(url: url, method: .get) { (result: Result<[UserResponseMain], Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        print("User received: \(user)")
                        completionHandler(nil)
                        self.userList = user
                    case .failure(let error):
                        completionHandler("\(error.localizedDescription)")
                        print("Error occurred: \(error.localizedDescription)")
                    }
                }
                
            }
        }
    }
}


struct UserResponseMain : Codable {
    let id : Int?
    let name : String?
    let username : String?
    let email : String?
    let address : Address?
    let phone : String?
    let website : String?
    let company : Company?
    
    var fullAddress: String {
        var fullAddressString: String = ""
        if let address {
            if let street = address.street {
                fullAddressString +=  street
            }
            
            if let suite = address.suite {
                fullAddressString += ", \(suite)"
            }
            
            if let city = address.city {
                fullAddressString += ", \(city)"
            }
            
            if let zipcode = address.zipcode {
                fullAddressString += ", \(zipcode)"
            }
            
            return fullAddressString
        }
        
        return ""
    }

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
    }

}


struct Address : Codable {
    let street : String?
    let suite : String?
    let city : String?
    let zipcode : String?
    let geo : Geo?

    enum CodingKeys: String, CodingKey {

        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        suite = try values.decodeIfPresent(String.self, forKey: .suite)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
        geo = try values.decodeIfPresent(Geo.self, forKey: .geo)
    }

}

struct Company : Codable {
    let name : String?
    let catchPhrase : String?
    let bs : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        catchPhrase = try values.decodeIfPresent(String.self, forKey: .catchPhrase)
        bs = try values.decodeIfPresent(String.self, forKey: .bs)
    }

}

struct Geo : Codable {
    let lat : String?
    let lng : String?

    enum CodingKeys: String, CodingKey {

        case lat = "lat"
        case lng = "lng"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
    }

}

