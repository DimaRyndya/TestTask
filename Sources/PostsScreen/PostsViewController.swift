import UIKit

final class PostsViewController: UITableViewController, PostsViewModelDeledate {

    // MARK: - Outlets

    @IBOutlet weak var menuButtonItem: UIBarButtonItem!
    
    let viewModel = PostsViewModel()
    var isSelectedDates = false
    var isSelectedLikes = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")

        configureButtonMenu()
        viewModel.delegate = self
        viewModel.viewDidLoad()

    }

    func reloadUI() {
        tableView.reloadData()
    }

    func configureButtonMenu() {
        let newest = UIAction(title: "Newest First", image: UIImage(systemName: "arrow.up")) { [weak self] _ in
            self?.isSelectedDates.toggle()
            self?.updateUIForDateMenu()
            self?.viewModel.sortByDateTapped(state: self!.isSelectedDates)
        }

        let oldest = UIAction(title: "Oldest First", image: UIImage(systemName: "arrow.down")) { [weak self] _ in
            self?.isSelectedDates.toggle()
            self?.updateUIForDateMenu()
            self?.viewModel.sortByDateTapped(state: self!.isSelectedDates)
        }

        let mostPopular = UIAction(title: "Most Popular", image: UIImage(systemName: "arrow.up")) { [weak self] _ in
            self?.isSelectedLikes.toggle()
            self?.updateUIForLikesMenu()
            self?.viewModel.sortByLikesTapped(state: self!.isSelectedLikes)
        }

        let lessPopular = UIAction(title: "Less Popular", image: UIImage(systemName: "arrow.down")) { [weak self] _ in
            self?.isSelectedLikes.toggle()
            self?.updateUIForLikesMenu()
            self?.viewModel.sortByLikesTapped(state: self!.isSelectedLikes)
        }

        let dateMenu = UIMenu(title: "Date", image: UIImage(systemName: "calendar"), children: [newest, oldest])
        let likesMenu = UIMenu(title: "Likes", image: UIImage(systemName: "heart"), children: [mostPopular, lessPopular])

        menuButtonItem.menu = UIMenu(title: "Sort By", children: [dateMenu, likesMenu])
    }

    func updateUIForMenu(menu: UIMenu, selectedActionTitle: String?) {
        for case let action as UIAction in menu.children {
            action.state = action.title == selectedActionTitle ? .on : .off
        }
    }

    func updateUIForDateMenu() {
        guard let menu = menuButtonItem.menu else { return }
        
        if let dateMenu = menu.children.first as? UIMenu {
            updateUIForMenu(menu: dateMenu, selectedActionTitle: isSelectedDates ? "Newest First" : "Oldest First")
        }

        if let likesMenu = menu.children.last as? UIMenu {
            updateUIForMenu(menu: likesMenu, selectedActionTitle: nil)
        }
    }

    func updateUIForLikesMenu() {
        guard let menu = menuButtonItem.menu else { return }

        if let likesMenu = menu.children.last as? UIMenu {
            updateUIForMenu(menu: likesMenu, selectedActionTitle: isSelectedLikes ? "Most Popular" : "Less Popular")
        }

        if let dateMenu = menu.children.first as? UIMenu {
            updateUIForMenu(menu: dateMenu, selectedActionTitle: nil)
        }
    }
}

extension PostsViewController: PostCellDelegate {

    // MARK: - PostCell Delegate

    func postCellDidChangeHeight(_ cell: PostCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

extension PostsViewController {

    // MARK: - TableView Data Source

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

    // MARK: - TableView Delegate

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
