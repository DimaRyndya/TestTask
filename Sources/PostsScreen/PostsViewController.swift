import UIKit

// MARK: - Constants

private enum Constants {
    static let newestFirst = "Newest First"
    static let oldestFirst = "Oldest First"
    static let mostPopular = "Most Popular"
    static let lessPopular = "Less Popular"
}

final class PostsViewController: UITableViewController, PostsViewModelOutput {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var menuButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    
    private let viewModel = PostsViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")
        
        configureButtonMenu()
        viewModel.output = self
        viewModel.viewDidLoad()
        
    }
    
    // MARK: - Public methods
    
    func reloadUI() {
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func configureButtonMenu() {
        let newest = UIAction(title: Constants.newestFirst, image: UIImage(systemName: "arrow.up")) { [weak self] _ in
            guard let self else { return }
            
            self.viewModel.filterButtonTapped(sortType: .date, isAscending: true)
            self.updateUIForDateMenu(isAscending: true)
        }
        
        let oldest = UIAction(title: Constants.oldestFirst, image: UIImage(systemName: "arrow.down")) { [weak self] _ in
            guard let self else { return }
            
            self.viewModel.filterButtonTapped(sortType: .date, isAscending: false)
            self.updateUIForDateMenu(isAscending: false)
        }
        
        let mostPopular = UIAction(title: Constants.mostPopular, image: UIImage(systemName: "arrow.up")) { [weak self] _ in
            guard let self else { return }
            
            self.viewModel.filterButtonTapped(sortType: .likes, isAscending: true)
            self.updateUIForLikesMenu(isAscending: true)
        }
        
        let lessPopular = UIAction(title: Constants.lessPopular, image: UIImage(systemName: "arrow.down")) { [weak self] _ in
            guard let self else { return }
            
            self.viewModel.filterButtonTapped(sortType: .likes, isAscending: false)
            self.updateUIForLikesMenu(isAscending: false)
        }
        
        let dateMenu = UIMenu(title: "Date", image: UIImage(systemName: "calendar"), children: [newest, oldest])
        let likesMenu = UIMenu(title: "Likes", image: UIImage(systemName: "heart"), children: [mostPopular, lessPopular])
        
        menuButtonItem.menu = UIMenu(title: "Sort By", children: [dateMenu, likesMenu])
    }
    
    private func updateUIForMenu(menu: UIMenu, selectedActionTitle: String?) {
        for case let action as UIAction in menu.children {
            action.state = action.title == selectedActionTitle ? .on : .off
        }
    }
    
    private func updateUIForDateMenu(isAscending: Bool) {
        guard let menu = menuButtonItem.menu else { return }
        
        if let dateMenu = menu.children.first as? UIMenu {
            updateUIForMenu(menu: dateMenu, selectedActionTitle: isAscending ? Constants.newestFirst : Constants.oldestFirst)
        }
        
        if let likesMenu = menu.children.last as? UIMenu {
            updateUIForMenu(menu: likesMenu, selectedActionTitle: nil)
        }
    }
    
    private func updateUIForLikesMenu(isAscending: Bool) {
        guard let menu = menuButtonItem.menu else { return }
        
        if let likesMenu = menu.children.last as? UIMenu {
            updateUIForMenu(menu: likesMenu, selectedActionTitle: isAscending ? Constants.mostPopular : Constants.lessPopular)
        }
        
        if let dateMenu = menu.children.first as? UIMenu {
            updateUIForMenu(menu: dateMenu, selectedActionTitle: nil)
        }
    }
}

// MARK: - PostCell Delegate

extension PostsViewController: PostCellDelegate {
    
    func postCellDidChangeHeight(_ cell: PostCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

extension PostsViewController {
    
    // MARK: - PostsTableView Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell ?? PostCell()
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - PostsTableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = viewModel.posts[indexPath.row]
        let storyboard = UIStoryboard(name: "PostStoryboard", bundle: nil)
        let postVC = storyboard.instantiateViewController(withIdentifier: "Post") as! DetailPostViewController
        
        postVC.viewModel.changeUIForState = { [weak postVC] state in
            postVC?.changeUI(for: state)
        }
        postVC.viewModel.loadPost(id: selectedPost.id)
        postVC.viewModel.postTitle = selectedPost.title
        postVC.viewModel.postLikes = String(selectedPost.likes)
        postVC.viewModel.timestamp = selectedPost.timestamp
        
        navigationController?.pushViewController(postVC, animated: true)
    }
}
