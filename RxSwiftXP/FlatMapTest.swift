//
//  FlatMapTest.swift
//  RxSwiftXP
//
//  Created by Lidiomar Machado on 18/12/21.
//

import Foundation
import RxSwift

class FlatMapTest {
    
    private static let disposeBag = DisposeBag()
    
    static func test() {
        let p = PublishSubject<Student>()
        
        p.flatMap { student in
            return student.score
        }.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        let s1 = Student(score: BehaviorSubject<Int>(value: 1))
        let s2 = Student(score: BehaviorSubject<Int>(value: 2))
        let s3 = Student(score: BehaviorSubject<Int>(value: 3))
        
        p.onNext(s1)
        p.onNext(s2)
        p.onNext(s3)
        
        s1.score.onNext(5)
        s2.score.onNext(6)
        s3.score.onNext(7)
        
    }
    
    struct Student {
        let score: BehaviorSubject<Int>
    }
}
