//
//  BankAccount.swift
//  SwiftBeginner
//
//  Created by Mohammad on 8/22/25.
//

import Foundation
import SwiftUI

@MainActor
class BanckViewModel: ObservableObject {
    
    @Published var balance: Double = 300.0
    private let account = BankAccount(initialBalance: 300.0)
    
    func preformTransaction() async throws {
        let transaction = 50
        
        for i in 1...transaction {
            let amount = Double.random(in: 1...100)
            let isDeposit = Bool.random()
            
            if isDeposit {
                try await account.desposit(amount: amount)
            } else {
                try await account.withdraw(amount: amount)
            }
//            
//            await MainActor.run {
//            }
            
            self.balance = await self.account.getBalance()

            try? await Task.sleep(nanoseconds: 100_000_000)
        }
    }
}

class BanckViewModelDispatch: ObservableObject {
    @Published var balance: Double = 300.0
    private let account = BanckAccountDispatch(balance: 300.0)
    
    func prefromTransaction() {
        let transaction = 50
        let group = DispatchGroup()
      
        
        for i in 1...transaction {
            group.enter()
            
            let amount = Double.random(in: 1...100)
            let isDeposit = Bool.random()
            
            if isDeposit {
                account.deposit(amount: amount) { [weak self] newBalance in
                    DispatchQueue.main.async {
                        self?.balance = newBalance
                    }
                    group.leave()
                }
            } else {
                account.withdraw(amount: amount) { [weak self] newBalance in
                    DispatchQueue.main.async {
                        self?.balance = newBalance
                    }
                    
                    group.leave()
                }
            }

            Thread.sleep(forTimeInterval: 0.1)
        }
        
        group.notify(queue: .main) {
            print("All Transaction do it.")
        }
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = BanckViewModel()
    @StateObject var viewModelDisptach = BanckViewModelDispatch()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Manage Account")
                .font(.title)
            
            // amount
            Text("now amount: \(viewModel.balance, specifier: "%.2f") $")
                .font(.headline)
            
            Button("Start Transaction with async/await") {
                Task {
                    try await viewModel.preformTransaction()
                }
            }
            
            Button("Start trnasction wit Dispatch") {
                viewModelDisptach.prefromTransaction()
            }
        }
        .padding()
    }
}


class BanckAccountDispatch {
    private var balance: Double
    private let threadSafeQueue: DispatchQueue
    
    init(balance: Double) {
        self.balance = balance
        self.threadSafeQueue = DispatchQueue(label: "com.bankaccount.queue", attributes: .concurrent)
    }
    
    func withdraw(amount: Double, completion: @escaping (Double) -> Void) {
        threadSafeQueue.async(flags: .barrier) {
            guard amount > 0 && amount <= self.balance else {
                print("error")
                return
            }
            
            self.balance -= amount
            completion(self.balance)
        }
    }
    
    func deposit(amount: Double, completion: @escaping (Double) -> Void) {
        threadSafeQueue.async(flags: .barrier) {
            guard amount > 0 else {
                return
            }
            
            self.balance += amount
            print("\(amount), new: \(self.balance)")
            completion(self.balance)
        }
    }
    
    
    func getBalance(completion: @escaping (Double) -> Void) {
        threadSafeQueue.async {
            completion(self.balance)
        }
    }
}

enum BanckError: CustomStringConvertible, Error {
    case insuffcientFound
    case invalidAmount
    case transactionFailed
    case accountLocked
    
    var description: String {
        switch self {
        case .insuffcientFound:
            return "insuffcientFound"
        case .invalidAmount:
            return "invalidAmount"
        case .transactionFailed:
            return "transactionFailed"
        case .accountLocked:
            return "accountLocked"
        }
    }
}

actor BankAccount {
    private var balance: Double
    
    init(initialBalance: Double) {
        self.balance = initialBalance
    }
    
    
    func withdraw(amount: Double) async throws {
        guard amount > 0 else {
            throw BanckError.invalidAmount
        }
        
        guard amount <= balance else {
            throw BanckError.insuffcientFound
        }
        
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        balance -= amount
        print("withDrow: \(amount), new: \(balance)")
    }
    
    func desposit(amount: Double) async throws {
        guard amount > 0 else {
            throw BanckError.invalidAmount
        }
        
        try await Task.sleep(nanoseconds: 100_000_000)
        balance += amount
        print("deposit: \(amount), new: \(balance))")
    }
    
    func getBalance() async -> Double {
        return balance
    }
    
    
    func prefromRandomTransaction(count: Int = 50) async {
        
        print("start transaction")
        print("first amount \(balance) $")
        
        for i in 1...count {
            let amount = Double.random(in: 1...100)
            let isDeposit = Bool.random()
            
            do {
                if isDeposit {
                    try await desposit(amount: amount)
                } else {
                    try await withdraw(amount: amount)
                }
            } catch {
                print("error in transaction \(i), error: \(error)")
            }
        }
        
        let finalBalance = await getBalance()
        
        print("all transaction do it.")
        print("Final Balance: \(finalBalance)")
    }
    
    
    func existBaance() async {
        let account = BankAccount(initialBalance: 300)
        
        print("Bacnk Aaccount Manager")
        print("First Amount")
        print("Random Transaction")
        
        await account.prefromRandomTransaction()
    }
}

class BanckAccountLock {
    private var balance: Double
    private let lock = NSLock()
    
    init(initialBalance: Double) {
        self.balance = initialBalance
    }
    
    func withdraw(amount: Double) async throws {
        guard amount > 0 else {
            throw BanckError.invalidAmount
        }
        
        guard amount <= balance else {
            throw BanckError.insuffcientFound
        }
        // thread safety
        lock.lock()
        
        defer { lock.unlock() }
        
        
        try await Task.sleep(nanoseconds: 100_000_000)
        balance -= amount
    }
    
    func deposit(amount: Double) async throws {
        guard amount > 0 else {
            throw BanckError.invalidAmount
        }
        
        lock.lock()
        defer { lock.unlock() }
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        balance += amount
        
        print("\(amount), new: \(self.balance)")
    }
    
    
    func getBalance() async -> Double {
        lock.lock()
        
        defer { lock.unlock() }
        return balance
    }
    
    func performTranscation(count: Int = 50) async {
        
        for i in 1...count {
            let amount = Double.random(in: 1...100)
            let isDeposit = Bool.random()
            
            do {
                
                if isDeposit {
                    try await deposit(amount: amount)
                } else {
                    try await withdraw(amount: amount)
                }
            } catch {
                print("Error Count: \(i) Error\( error)")
            }
        }
        
        let finalBalance = await getBalance()
        
        print(finalBalance)
    }
    
    
    func existBalance() {
        Task {
            let account = BanckAccountLock(initialBalance: 300.0)
            
            await account.performTranscation()
        }
    }
}
