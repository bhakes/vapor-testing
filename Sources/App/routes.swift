import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello", "vapor") { req in
        return "Hello, Vapor!"
    }
    
    // Basic "Hello, [name]!" example
    router.get("hello", String.parameter) { req -> String in
        //2
        let name = try req.parameters.next(String.self)
        // 3
        return "Hello, \(name)!"
    }
    
    router.post(InfoData.self, at: "info") { req, data -> String in
        return "Hello, \(data.name)!"
    }
    
    // 1
    router.post(InfoData.self, at: "info") {
        req, data -> InfoResponse in
        // 2
        return InfoResponse(request: data)
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let request: InfoData
}
