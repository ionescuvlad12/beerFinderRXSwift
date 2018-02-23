import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    func sort(input: Input?, ascending:Bool) -> Output
    func beerByFood(input: Input?, food:String) -> Output
}
