//
//  User.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-01-26.
//

import Foundation

@available(iOS 15.0, *)
protocol UserProtocol {
    var user: User {get set}
}

@available(iOS 15.0, *)
struct Like : Identifiable {
    var id : UUID
    var likeBy : [User]
}

@available(iOS 15.0, *)
struct Comment : Identifiable {
    var id : UUID
    var comment : String
    var likes: [Like]
}

@available(iOS 15.0, *)
struct PostFeed  {
    var type: PostType
    var likes: [Like]
    var comments: [Comment]
}

@available(iOS 15.0, *)
class Profile : Codable {
    var id: UUID
    var user: User = User()
    var address: String = ""
   
    enum CodingKeys: CodingKey {
        case id, user, address
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(id, forKey: .id)
            try container.encode(user, forKey: .user)
            try container.encode(address, forKey: .address)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        user = try container.decode(User.self, forKey: .user)
        address = try container.decode(String.self, forKey: .address)
    }
    
}

@available(iOS 15.0, *)
class User : ObservableObject, Codable {
    @Published var username: String = ""
    @Published var password: String?
    @Published var isAuthenticated: Bool = false
    @Published var profile: Profile?
    
    enum CodingKeys: CodingKey {
        case username, password, isAuthenticated, profile
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(username, forKey: .username)
            try container.encode(isAuthenticated, forKey: .isAuthenticated)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        isAuthenticated = try container.decode(Bool.self, forKey: .isAuthenticated)
        profile = try container.decode(Profile.self, forKey: .profile)
    }
    
   init() {}

    @MainActor
    func authenticate(user: User) async -> User {
        if ( user.username.lowercased() == "admin" && user.password?.lowercased() == "password") {
            user.isAuthenticated = true
        }
       // print(user.username)
        //print(user.password)
        return user
    }
   
    @MainActor
    func getLoggedInUser( user: User ) async -> (LoginResponseModel) {
        let profile = user.profile
            
        let loggedInUser: LoginResponseModel = LoginResponseModel.init(username: user.username, isAutenticated: user.isAuthenticated, profile: profile)
        return loggedInUser
    }
}

struct LoginErrorModel: Codable {
    var status: String?
    var errorCode: Int?
}

@available(iOS 15.0, *)
struct LoginResponseModel : Codable {
    var username: String
    var isAutenticated: Bool
    var profile: Profile?
    var errorStatus: LoginErrorModel?
}
