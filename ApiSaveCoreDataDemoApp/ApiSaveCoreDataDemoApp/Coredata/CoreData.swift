
import UIKit
import CoreData

class CoreData {
    
    static let sharedInstance = CoreData()
    private init(){}
    
    private let continer: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private let fetchRequest = NSFetchRequest<Unicorns>(entityName: "Unicorns")
    
    func saveDataOf(movies:[Unicorns]) {
        
        // Updates CoreData with the new data from the server - Off the main thread
        self.continer?.performBackgroundTask{ [weak self] (context) in
            self?.deleteObjectsfromCoreData(context: context)
            self?.saveDataToCoreData(movies: movies, context: context)
        }
    }
    
    // MARK: - Delete Core Data objects before saving new data
    private func deleteObjectsfromCoreData(context: NSManagedObjectContext) {
        do {
            // Fetch Data
            let objects = try context.fetch(fetchRequest)
            
            // Delete Data
            _ = objects.map({context.delete($0)})
            
            // Save Data
            try context.save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }
    
    // MARK: - Save new data from the server to Core Data
    private func saveDataToCoreData(movies:[Unicorns], context: NSManagedObjectContext) {
        // perform - Make sure that this code of block will be executed on the proper Queue
        // In this case this code should be perform off the main Queue
        context.perform {
            for movie in movies {
                let movieEntity = Unicorns(context: context)
                movieEntity.id = movie.id
                movieEntity.age = movie.age
                movieEntity.name = movie.name
                movieEntity.colour = movie.colour
            }
            // Save Data
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
