import UIKit
import Domain
import RxSwift
import RxCocoa

class BeersViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: BeersViewModel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortBeerButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    var ascending:Bool = true
    var beersList:[Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        search()
        bindViewModel()
        
    }
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    @IBAction func onSortTaped(_ sender: Any) {
        sort()
        self.ascending = !self.ascending
    }
    
    
    private func search() {
        assert(viewModel != nil)

        searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                let output = self.viewModel.beerByFood(input: nil, food: self.searchBar.text!)
                self.tableView.dataSource = nil
                output.beers.drive(self.tableView.rx.items(cellIdentifier: BeerTableViewCell.reuseID, cellType: BeerTableViewCell.self)) { tv, viewModel, cell in
                    cell.bind(viewModel)

                    }.addDisposableTo(self.disposeBag)
                //Connect Create Beer to UI

                output.fetching
                    .drive(self.tableView.refreshControl!.rx.isRefreshing)
                    .disposed(by: self.disposeBag)
        }).addDisposableTo(self.disposeBag)
    }
    
    private func sort() {
        assert(viewModel != nil)
        // NOT OK
        tableView.dataSource = nil
        let output = viewModel.sort(input: nil, ascending: self.ascending)
        //Bind Beers to UITableView
        output.beers.drive(tableView.rx.items(cellIdentifier: BeerTableViewCell.reuseID, cellType: BeerTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
            
            }.addDisposableTo(disposeBag)
        //Connect Create Beer to UI
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        output.sortBeer
            .drive()
            .disposed(by: disposeBag)
        
    }

    
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = BeersViewModel.Input(trigger: Driver.merge(viewWillAppear, pull))
        let output = viewModel.transform(input: input)
        //Bind Beers to UITableView
        output.beers.drive(tableView.rx.items(cellIdentifier: BeerTableViewCell.reuseID, cellType: BeerTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)

        }.addDisposableTo(disposeBag)
        //Connect Create Beer to UI
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}



