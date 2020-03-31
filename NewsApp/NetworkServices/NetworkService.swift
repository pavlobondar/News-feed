//
//  NetworkServices.swift
//  NewsApp
//
//  Created by Pavel Bondar on 16.02.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

class NetworkService {
    private let API_KEY = "YOUR_KEY"
    
    struct Users: Codable {
        let data: [UserList]
    }
    
    struct UserList: Codable {
        let id: Int
        let email: String
        let first_name: String
        let last_name: String
    }
    
    
    
    
    struct CoursesList: Codable {
        var courses: [Courses]
    }
    
    struct Courses: Codable {
        var id: Int
        var title: String
        var lecturer_id: Int
        var created_at: String
    }

    func fetchCoursesList() {
        guard let url = URL(string: "https://quick-test-test-server.herokuapp.com/api/documents/courses") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("aa76d406-db38-4508-8ed6-65b569fcb161", forHTTPHeaderField: "X-Auth-Token")
        let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    func fetchDataGET() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reqres.in"
        components.path = "/api/users"
        components.queryItems = [URLQueryItem(name: "page", value: "2")]
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let courses = try JSONDecoder().decode(Users.self, from: data)
                        print(courses)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }.resume()
    }
    
    func fetchDataPOST() {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        let parameters = ["name": "morpheus", "job" : "leader"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchDataPUT() {
        guard let url = URL(string: "https://reqres.in/api/users/2") else { return }
        let parameters = ["name": "morpheus", "job" : "zion resident"]
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchNewsFeed(completionHandler: @escaping (NewsFeed?, Error?) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [URLQueryItem(name: "country", value: "ua"),
                                 URLQueryItem(name: "apiKey", value: API_KEY)]
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let news = try JSONDecoder().decode(NewsFeed.self, from: data)
                        completionHandler(news, nil)
                    } catch {
                        print(error.localizedDescription)
                        completionHandler(nil, error)
                    }
                }
        }.resume()
    }
}
