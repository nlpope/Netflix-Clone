//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Noah Pope on 12/13/22.
//

import Foundation

class APICaller {
    
    static let shared       = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], NCAPIError>) -> Void) {
        guard let url       = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task            = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                //instead of printing the err, we're passing in a failure to handle it directly from home viewcontroller
                completion(.failure(NCAPIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], NCAPIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NCAPIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getPopularMovies(completion: @escaping (Result<[Title], NCAPIError>) -> Void) {
        guard let url       = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(NCAPIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], NCAPIError>) -> Void) {
        guard let url       = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(NCAPIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    
    func getTopRated(completion: @escaping (Result<[Title], NCAPIError>) -> Void) {
        guard let url       = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        
        let task            = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(NCAPIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], NCAPIError>) -> Void) {
        guard let url       = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(NCAPIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        //formats the url by replacing whitespace for '%20' in url so we can use it w/out error
        guard let query     = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url       = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        
        let task            = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(NCAPIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query     = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url       = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
       
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
