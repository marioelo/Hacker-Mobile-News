//
//  PersistenceManager.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 09-05-21.
//

import CoreData

class PersistenceManager {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    func saveStorie(_ storyServerModel: StoryServerModel) {
        guard
            let author = storyServerModel.author,
            let id = storyServerModel.storyId,
            let createdAt = storyServerModel.createdAt,
            let title = storyServerModel.storyTitle ?? storyServerModel.title,
            let url = storyServerModel.storyUrl
        else { return }
        DispatchQueue.main.async {
            let story = Story(context: self.context)
            story.author = author
            story.id = Int64(id)
            story.createdAt = createdAt
            story.title = title
            story.url = url
            do {
                try self.context.save()
            } catch {
                print("There was an error saving the new Story to Core Data")
                print(error)
            }
        }
        
    }
    
    func removeStory(_ story: Story, completed: @escaping () -> Void) {
        story.isRemoved = true
        do {
            try context.save()
            completed()
        } catch {
            print("There was an error deleting the book! \(error)")
        }
    }
    
    func loadStories(completed: @escaping (Result<[Story], Error>) -> Void) {
        let request: NSFetchRequest = Story.fetchRequest()
        let sortByCreatedAtDate = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortByCreatedAtDate]
        request.predicate = NSPredicate(format: "isRemoved == %@", NSNumber(booleanLiteral: false))
        do {
            let stories = try context.fetch(request)
            completed(.success(stories))
        }
        catch {
            completed(.failure(error))
        }
    }
    
    func updateStories(completed: @escaping (Result<[Story], Error>) -> Void) {
        
    }
    
}
