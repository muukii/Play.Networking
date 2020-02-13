//
//  ContentView.swift
//  Networking
//
//  Created by muukii on 2020/02/13.
//  Copyright © 2020 muukii. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Button(action: {
        Service.shared.dispatch()
      }) {
        Text("Dispatch")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

import Moya

final class Service {
  
  static let shared = Service()
  
  let provider: MoyaProvider<Get>
  
  init() {
    
    let configuration = URLSessionConfiguration.background(withIdentifier: "app.sample")
//    configuration.timeoutIntervalForRequest = 5
    configuration.timeoutIntervalForResource = 5
    
    let manager = Manager.init(configuration: configuration)
        
    self.provider = MoyaProvider(manager: manager, plugins: [Plugin()])
    
  }
        
  func dispatch() {
    
    provider.request(Get()) { (result) in
      print(result)
    }
    
  }
  
}

struct Plugin: PluginType {
  
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var r = request
//    r.timeoutInterval = 5
    return r
  }
}

struct Get: TargetType {
  var baseURL: URL = URL.init(string: "https://httpbin.org/")!
  
  var path: String = "get"
  
  var method: Moya.Method = .get
  
  var sampleData: Data {
    Data()
  }
  
  var task: Task = .requestParameters(parameters: ["hello" : "hello"], encoding: URLEncoding.default)
  
  var headers: [String : String]? = [:]
    
}
