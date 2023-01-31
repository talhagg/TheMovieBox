//
//  DataPersistenceManager.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 30.01.2023.
//

import CoreData
import UIKit

protocol DataPersistManagerProtocol {
    func saveMovies(model: MoviePresentation)
    func fetchMoviesFromDatabase(completion: @escaping(Result<[MovieItem],Error>) -> Void)
    func deleteMovieWith(model: MovieItem)
}


final class DataPersistenceManager : DataPersistManagerProtocol {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    func saveMovies(model: MoviePresentation) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = MovieItem(context: context)
        
        
        item.id = Int64(model.id)
        item.title = model.title
        item.overview = model.overview
        item.image = model.image
                
        do {
            try context.save()
            
        } catch {
            print(DatabaseError.failedToSaveData)
        }
    }
    
    func fetchMoviesFromDatabase(completion: @escaping(Result<[MovieItem],Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<MovieItem>
        
        request = MovieItem.fetchRequest()
        
        do {
            let movies = try context.fetch(request)
            completion(.success(movies))
            
            
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteMovieWith(model: MovieItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
        } catch {
            print(DatabaseError.failedToDeleteData)
                
        }
        
    }
    
}
